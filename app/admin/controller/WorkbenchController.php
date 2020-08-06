<?php

namespace app\admin\controller;

use think\facade\View;

class WorkbenchController extends BasicController
{
    //工作台 View
    public function index()
    {
        //模拟工作台数据
        $day = 14;
        $income = [];
        for ($i = $day; $i >= 0; $i--) {
            $date =  date('Y-m-d', strtotime(-$i . "day"));
            $income[] = ['time' => $date, 'total' => mt_rand(50, 200)];
        };
        $overview = [
            'todayMember' => mt_rand(10, 100),
            'todayOrder' => mt_rand(10, 100),
            'todayIncome' => mt_rand(10, 100),
            'totalMember' => mt_rand(100, 500),
            'totalOrder' => mt_rand(100, 500),
            'totalIncome' => mt_rand(100, 500),
        ];
        $result = [
            'income' => json_encode($income),
            'overview' => $overview,
        ];
        View::assign($result);
        return View::fetch();
    }
}
