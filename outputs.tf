output "load_balancer_ip" {
  value = [for listener in yandex_lb_network_load_balancer.lamp_lb.listener : [for addr in listener.external_address_spec : addr.address][0]][0]
}