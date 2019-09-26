<?php
namespace app\common\facade;

class CommonFacade
{
    /**
     * 字符串解密
     * @param string $string 需要解密的字符串
     * @param string $key秘钥
     * @return string
     */
    public static function decode(string $string, string $key = '')
    {
        $code = "";
        $key = md5($key);
        $key_length = strlen($key);
        $string = base64_decode($string);
        $string_length = strlen($string);
        $rndKey = $box = array();
        $result = '';
        for ($i = 0; $i <= 255; $i++) {
            $rndKey[$i] = ord($key[$i % $key_length]);
            $box[$i] = $i;
        }
        for ($j = $i = 0; $i < 256; $i++) {
            $j = ($j + $box[$i] + $rndKey[$i]) % 256;
            $tmp = $box[$i];
            $box[$i] = $box[$j];
            $box[$j] = $tmp;
        }
        for ($a = $j = $i = 0; $i < $string_length; $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $box[$a]) % 256;
            $tmp = $box[$a];
            $box[$a] = $box[$j];
            $box[$j] = $tmp;
            $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
        }
        if (substr($result, 0, 8) == substr(md5(substr($result, 8) . $key), 0, 8)) {
            $code = substr($result, 8);
        }
        return $code;
    }

    /**
     * 字符串加密
     * @param string $string 需要加密的字符串
     * @param string $key秘钥
     * @return string
     */
    public static function encode(string $string, string $key = '')
    {
        $key = md5($key);
        $key_length = strlen($key);
        $string = substr(md5($string . $key), 0, 8) . $string;
        $string_length = strlen($string);
        $rndKey = $box = array();
        $result = '';
        for ($i = 0; $i <= 255; $i++) {
            $rndKey[$i] = ord($key[$i % $key_length]);
            $box[$i] = $i;
        }
        for ($j = $i = 0; $i < 256; $i++) {
            $j = ($j + $box[$i] + $rndKey[$i]) % 256;
            $tmp = $box[$i];
            $box[$i] = $box[$j];
            $box[$j] = $tmp;
        }
        for ($a = $j = $i = 0; $i < $string_length; $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $box[$a]) % 256;
            $tmp = $box[$a];
            $box[$a] = $box[$j];
            $box[$j] = $tmp;
            $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
        }
        return str_replace('=', '', base64_encode($result));
    }

}
