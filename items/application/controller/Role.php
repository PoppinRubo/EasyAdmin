<?php
namespace app\controller;

use app\model\SysRole;
use think\Exception;

class Role extends Basic
{
    //角色列表 View
    public function index()
    {
        //获取按钮
        $this->assign('button', $this->getModuleButton());
        return View();
    }

    //添加角色 View || Json
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
                $model = new SysRole();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysRole');
        $this->assign('model', convertInitials($model));
        return View();
    }

    //编辑角色 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysRole();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysRole::get($id)->getData();
        $this->assign('model', convertInitials($model));
        return View();
    }

    //删除角色 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "IsDel" => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            );
            $model = new SysRole();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取角色列表
    public function getRoleList()
    {
        try {
            $limit = input("limit") ?: 10;
            $key = input("key") ?: "";
            $data = db('sys_role')->where(array("IsDel" => 0))->where(is_numeric($key) ? 'Id' : 'Name', 'like', '%' . $key . '%')->paginate($limit);
            return toEasyTable($data);
        } catch (Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }
}
