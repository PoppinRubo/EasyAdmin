<?php
namespace app\common\facade;

//返回结果
class ResultFacade
{
    //状态码
    public $code;
    //处理信息
    public $msg;
    //返回数据
    public $data;

    public function __construct($code = 0, $msg = '', $data = [])
    {
        $this->code = $code;
        $this->msg = $msg;
        $this->data = $data;
    }
}
