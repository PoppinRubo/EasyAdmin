<?php
namespace app\controller;

use app\model\SysButton;
use think\Controller;
use think\Exception;

class Button extends Basic
{
    //按钮列表 View
    public function index()
    {
        //获取按钮
        $this->assign('button', $this->getModuleButton(5));
        return View();
    }

    //添加按钮 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                $model = new SysButton();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysButton');
        $this->assign('model', convertInitials($model));
        return View();
    }

    //编辑按钮 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysButton();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysButton::get($id)->getData();
        $this->assign('model', convertInitials($model));
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
            $model = new SysButton();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取按钮列表
    public function getButtonList()
    {
        try {
            $limit = input("limit") ?: 10;
            $key = input("key") ?: "";
            $data = db('sys_button')->where(array("IsDel" => 0))->where(is_numeric($key) ? 'Id' : 'Name', 'like', '%' . $key . '%')->order("Sort", "ASC")->paginate($limit);
            return toLayTable($data);
        } catch (Exception $e) {
            return toLayTable([], false, -1, $e->getMessage());
        }
    }
}
