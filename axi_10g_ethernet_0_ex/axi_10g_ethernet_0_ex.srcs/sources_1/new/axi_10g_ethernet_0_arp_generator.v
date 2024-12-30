module axi_10g_ethernet_0_arp_generator(
    input                               aclk                    ,
    input                               areset                  ,

    input                               tx_arp_en               ,
    input                               arp_rx_type             ,
    input       [47:0]                  arp_src_mac             ,
    input       [31:0]                  arp_src_ip              ,

    output      [63:0]                  tx_axis_tdata           ,
    output      [7:0]                   tx_axis_tkeep           ,
    output                              tx_axis_tvalid          ,
    output                              tx_axis_tlast           ,
    input                               tx_axis_tready          ,

    input       [31:0]                  arp_request_ip          ,
    input                               tx_tcp_en               ,
    output                              tc_tcp_tready
);

wire            arp_reply_tready            ;
wire            arp_request_tready          ;      
wire            arp_reply_en                ;    
wire            arp_request_en              ;  

// 模块负责生成arp响应报文，同时内部存储ip-mac表
axi_10g_ethernet_0_arp_reply arp_reply ( 
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .tx_arp_en                       (tx_arp_en)                ,
    .arp_rx_type                     (arp_rx_type)              ,
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)               ,

    .tx_axis_tdata                   (tx_axis_tdata)            ,
    .tx_axis_tkeep                   (tx_axis_tkeep)            ,
    .tx_axis_tvalid                  (tx_axis_tvalid)           ,
    .tx_axis_tlast                   (tx_axis_tlast)            ,
    .tx_axis_tready                  (tx_axis_tready)           ,

    .arp_reply_tready                (arp_reply_tready)                 // 控制arp_reply发送报文
);


// 模块负责生成arp请求报文
axi_10g_ethernet_0_arp_request arp_request ( 
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .arp_request_ip                  (arp_request_ip)           ,       // tcp层发送报文的ip
    .tx_tcp_en                       (tx_tcp_en)                ,       // tcp发送报文使能信号
    .tx_tcp_tready                   (tx_tcp_tready)                    // tcp允许发送报文
);

// 模块控制arp_reply arp_request
axi_10g_ethernet_0_arp_control arp_control ( 
    .aclk                               (aclk)                  ,
    .areset                             (areset)                ,

    .arp_request_en                     (arp_request_en)        ,
    .arp_request_tready                 (arp_request_tready)    ,
    .arp_reply_en                       (arp_reply_en)          ,
    .arp_reply_tready                   (arp_reply_tready)      
);

endmodule
