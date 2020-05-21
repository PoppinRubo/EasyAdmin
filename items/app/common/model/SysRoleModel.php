<?php
namespace app\common\model;

use think\Model;

class SysRoleModel extends Model
{
	//表名
	protected $table = 'sys_role';
	//主键
	protected $pk = 'id';
	//模型数据不区分大小写
	protected $strict = false;
}
