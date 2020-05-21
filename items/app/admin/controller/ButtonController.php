<?php
namespace app\admin\controller;

use app\common\model\SysButtonModel;
use think\facade\Db;
use think\facade\View;

class ButtonController extends BasicController
{
    //按钮列表 View
    public function index()
    {
        //获取按钮
        View::assign(['button' => $this->getModuleButton()]);
        return View::fetch();
    }

    //添加按钮 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["create_time"] = date("Y-m-d H:i:s");
                $data["create_user"] = $this->user["id"];
                $data["modify_time"] = $data["create_time"];
                $data["modify_user"] = $data["create_user"];
                $model = new SysButtonModel();
                // 过滤表单数组中的非数据表字段数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                error($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $model = getEmptyModel('SysButton');
         View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //编辑按钮 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["modify_time"] = date("Y-m-d H:i:s");
                $data["modify_user"] = $this->user["id"];
                //更新数据
                $model = SysButtonModel::find($data["id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                error($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysButtonModel::find($id)->getData();
        View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //删除按钮 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "is_del" => 1,
                "modify_time" => date("Y-m-d H:i:s"),
                "modify_user" => $this->user["id"],
            );
            //更新数据
            $model = SysButtonModel::find($id);
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            error($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //获取按钮列表 Json
    public function getButtonList()
    {
        try {
            $limit = input("rows") ?: 10;
            $key = input("key") ?: "";
            $sort = input("sort") ?: "Sort";
            $order = input("order") ?: "ASC";
            //查询条件
            $where = [['is_del', '=', 0]];
            if (!empty($key)) {
                //编号查询
                if (is_numeric($key)) {
                    $where[] = ['id', '=', $key];
                } else {
                    //名称查询
                    $where[] = ['Name', 'like', '%' . $key . '%'];
                }
            }
            $data = Db::name('sys_button')->where($where)->order($sort, $order)->paginate($limit);
            return toEasyTable($data);
        } catch (\Exception $e) {
            error($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting()
    {
        //为方便调整顺序将按钮按顺序大小自动排序为间隔为10的顺序
        try {
            $list = Db::name('sys_button')->where(array("is_del" => 0))->order("Sort", "ASC")->select()->toArray();
            if ($list == null) {
                return jsonOut(config('code.error'), "操作失败,没有按钮");
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
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            error($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }
}
