resource "tencentcloud_vpc" "this" {
  count        = var.enabled ? 1 : 0
  name         = var.vpc_name
  cidr_block   = var.vpc_cidr
  is_multicast = var.vpc_is_multicast
  dns_servers  = length(var.vpc_dns_servers) > 0 ? var.vpc_dns_servers : null
  tags         = var.tags
}

resource "tencentcloud_subnet" "subnet" {
  count             = var.enabled ? length(var.subnet_cidrs) : 0
  name              = join("-", ["subnet", chomp(var.availability_zones[count.index % length(var.availability_zones)])])
  vpc_id            = tencentcloud_vpc.this.0.id
  cidr_block        = var.subnet_cidrs[count.index]
  is_multicast      = var.subnet_is_multicast
  availability_zone = var.availability_zones[count.index]
  route_table_id    = tencentcloud_route_table.this.0.id
  tags              = var.tags
}
resource "tencentcloud_subnet" "eni_subnet" {
  count             = var.enabled ? length(var.eni_subnet_cidrs) : 0
  name              = join("-", ["eni-subnet", chomp(var.availability_zones[count.index % length(var.availability_zones)])])
  vpc_id            = tencentcloud_vpc.this.0.id
  cidr_block        = var.eni_subnet_cidrs[count.index]
  is_multicast      = var.subnet_is_multicast
  availability_zone = var.availability_zones[count.index]
  route_table_id    = tencentcloud_route_table.this.0.id
  tags              = var.tags
}

### NAT Gateway ###
resource "tencentcloud_eip" "nat_eip" {
  count                      = var.enabled && var.enable_nat_gateway ? 1 : 0
  name                       = substr(join("-", [var.vpc_name, "eip"]), 0, 20)
  internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR"
  internet_max_bandwidth_out = var.nat_eip_max_bandwidth
  tags                       = var.tags
  lifecycle {
    ignore_changes = [internet_max_bandwidth_out]
  }
}

resource "tencentcloud_nat_gateway" "this" {
  count            = var.enabled && var.enable_nat_gateway ? 1 : 0
  name             = join("-", [var.vpc_name, "ngw"])
  vpc_id           = tencentcloud_vpc.this.0.id
  bandwidth        = 100
  max_concurrent   = 1000000
  assigned_eip_set = [tencentcloud_eip.nat_eip.0.public_ip]
  tags             = var.tags
}

resource "tencentcloud_route_table" "this" {
  count  = var.enabled ? 1 : 0
  vpc_id = tencentcloud_vpc.this.0.id
  name   = join("-", [var.vpc_name, "rtb"])
}

resource "tencentcloud_route_table_entry" "this" {
  count                  = var.enabled && var.enable_nat_gateway ? 1 : 0
  route_table_id         = tencentcloud_route_table.this.0.id
  destination_cidr_block = "0.0.0.0/0"
  next_type              = "NAT"
  next_hub               = tencentcloud_nat_gateway.this.0.id
  description            = "description"
}

resource "tencentcloud_nat_gateway_snat" "snat" {
  count             = var.enabled && var.enable_nat_gateway ? length(tencentcloud_subnet.subnet.*.id) : 0
  nat_gateway_id    = tencentcloud_nat_gateway.this.0.id
  resource_type     = "SUBNET"
  subnet_id         = tencentcloud_subnet.subnet[count.index].id
  subnet_cidr_block = tencentcloud_subnet.subnet[count.index].cidr_block
  description       = "description"
  public_ip_addr    = [tencentcloud_eip.nat_eip.0.public_ip]
}

resource "tencentcloud_nat_gateway_snat" "snat_eni" {
  count             = var.enabled && var.enable_nat_gateway ? length(tencentcloud_subnet.eni_subnet.*.id) : 0
  nat_gateway_id    = tencentcloud_nat_gateway.this.0.id
  resource_type     = "SUBNET"
  subnet_id         = tencentcloud_subnet.eni_subnet[count.index].id
  subnet_cidr_block = tencentcloud_subnet.eni_subnet[count.index].cidr_block
  description       = "description"
  public_ip_addr    = [tencentcloud_eip.nat_eip.0.public_ip]
}
