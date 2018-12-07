<?php
namespace app\controller;

use app\model\SysButtonModel;
use think\Exception;

class ButtonController extends BasicController
{
    //按钮列表 View
    public function index()
    {
        //获取按钮
        $this->assign('button', $this->getModuleButton());
        return View();
    }

    //添加按钮 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertToupper(input());
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                $model = new SysButtonModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysButton');
        $this->assign('model', convertLower($model));
        return View();
    }

    //编辑按钮 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertToupper(input());
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysButtonModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysButtonModel::get($id)->getData();
        $this->assign('model', convertLower($model));
        return View();
    }

    //删除按钮 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "IsDel" => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            );
            $model = new SysButtonModel();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取按钮列表 Json
    public function getButtonList()
    {
        try {
            $limit = input("rows") ?: 10;
            $key = input("key") ?: "";
            $data = db('sys_button')->where(array("IsDel" => 0))->where(is_numeric($key) ? 'Id' : 'Name', 'like', '%' . $key . '%')->order("Sort", "ASC")->paginate($limit);
            return toEasyTable($data);
        } catch (Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting()
    {
        //为方便调整顺序将按钮按顺序大小自动排序为间隔为10的顺序
        try {
            $list = db('sys_button')->where(array("IsDel" => 0))->order("Sort", "ASC")->select();
            if ($list == null) {
                return toJsonData(0, null, "操作失败,没有按钮");
            }
            $sort = 10;
            $data = array();
            foreach ($list as $l) {
                $l['Sort'] = $sort;
                $data[] = $l;
                //以间隔为10递增
                $sort += 10;
            }
            //批量更新数据
            $model = new SysButtonModel;
            $model->saveAll($data);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }
}
