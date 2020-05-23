<?php

namespace app\admin\controller;

use think\facade\View;

class IconController extends BasicController
{
    public function index()
    {
        return View::fetch();
    }
}
