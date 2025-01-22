module axi_10g_ethernet_0_arp_generator #(
    parameter           show_output_block           =           1           
)
(
    input                               aclk                    ,
    input                               areset                  ,

    // 接收parser模块解析数据
    input                               tx_arp_en               ,
    input                               arp_rx_type             ,
    input       [47:0]                  arp_src_mac             ,
    input       [31:0]                  arp_src_ip              ,

    // 输出数据
    output      [63:0]                  tx_axis_tdata           ,
    output      [7:0]                   tx_axis_tkeep           ,
    output                              tx_axis_tvalid          ,
    output                              tx_axis_tlast           ,
    input                               tx_axis_tready          ,

    // 上层发送报文时查询ip地址映射接口
    input       [31:0]                  arp_request_ip          ,
    input                               tx_tcp_en               ,
    output                              tx_tcp_tready           ,
    input                               tx_tcp_done             
); 

wire    [63:0]  arp_reply_tdata             ;
wire    [ 7:0]  arp_reply_tkeep             ;
wire            arp_reply_tvalid            ;
wire            arp_reply_tlast             ;

wire    [63:0]  arp_request_tdata           ;
wire    [ 7:0]  arp_request_tkeep           ;
wire            arp_request_tvalid          ;
wire            arp_request_tlast           ;

wire            arp_reply_tready            ;   
wire            arp_reply_en                ;
wire            arp_reply_done              ;

wire            arp_request_tready          ;   
wire            arp_request_en              ;
wire            arp_request_done            ;

// 模块负责生成arp响应报文
axi_10g_ethernet_0_arp_reply arp_reply ( 
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .tx_arp_en                       (tx_arp_en)                ,
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)               ,

    .tx_axis_tdata                   (arp_reply_tdata)          ,
    .tx_axis_tkeep                   (arp_reply_tkeep)          ,
    .tx_axis_tvalid                  (arp_reply_tvalid)         ,
    .tx_axis_tlast                   (arp_reply_tlast)          ,

    .arp_reply_tready                (arp_reply_tready)         ,       // 控制arp_reply发送报文
    .arp_reply_en                    (arp_reply_en)             ,
    .arp_reply_done                  (arp_reply_done)
);


// 模块负责生成arp请求报文，同时内部存储ip-mac表
axi_10g_ethernet_0_arp_request arp_request ( 
    .aclk                            (aclk)                     ,
    .areset                          (areset)                   ,

    .arp_request_ip                  (arp_request_ip)           ,       // tcp层发送报文的ip
    .tx_tcp_en                       (tx_tcp_en)                ,       // tcp发送报文使能信号
    .tx_tcp_tready                   (tx_tcp_tready)            ,       // tcp允许发送报文
    .tx_tcp_done                     (tx_tcp_done)              ,

    .arp_rx_type                     (arp_rx_type)              ,       // 值为1时表示接收arp应答报文，填list表
    .arp_src_mac                     (arp_src_mac)              ,
    .arp_src_ip                      (arp_src_ip)               ,

    .arp_request_tready              (arp_request_tready)       ,
    .arp_request_en                  (arp_request_en)           ,
    .arp_request_done                (arp_request_done)         ,

    .tx_axis_tdata                   (arp_request_tdata)        ,
    .tx_axis_tkeep                   (arp_request_tkeep)        ,
    .tx_axis_tvalid                  (arp_request_tvalid)       ,
    .tx_axis_tlast                   (arp_request_tlast)        
);

// 模块控制arp_reply arp_request
axi_10g_ethernet_0_arp_control #(
    .show_output_block                  (show_output_block)  
)
arp_control ( 
    .aclk                               (aclk)                  ,
    .areset                             (areset)                ,

    .arp_request_en                     (arp_request_en)        ,
    .arp_request_tready                 (arp_request_tready)    ,
    .arp_request_done                   (arp_request_done)      ,

    .arp_reply_en                       (arp_reply_en)          ,
    .arp_reply_tready                   (arp_reply_tready)      ,
    .arp_reply_done                     (arp_reply_done)        ,

    .arp_reply_tdata                    (arp_reply_tdata)       ,
    .arp_reply_tkeep                    (arp_reply_tkeep)       ,
    .arp_reply_tvalid                   (arp_reply_tvalid)      ,
    .arp_reply_tlast                    (arp_reply_tlast)       ,

    .arp_request_tdata                  (arp_request_tdata)     ,
    .arp_request_tkeep                  (arp_request_tkeep)     ,
    .arp_request_tvalid                 (arp_request_tvalid)    ,
    .arp_request_tlast                  (arp_request_tlast)     ,

    .tx_axis_tdata                      (tx_axis_tdata)         ,
    .tx_axis_tkeep                      (tx_axis_tkeep)         ,
    .tx_axis_tvalid                     (tx_axis_tvalid)        ,
    .tx_axis_tlast                      (tx_axis_tlast)         ,
    .tx_axis_tready                     (tx_axis_tready)        
);

endmodule
