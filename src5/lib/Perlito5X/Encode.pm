package Encode;
use strict;

sub encode_utf8 {
    if (@_) {
    Java::inline '
        String s = List__.shift().toString();
        byte[] bytes = s.getBytes("UTF-8");
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append((char)b);
        }
        return new PlString(sb.toString())
    ';
    }
    return undef;
}

sub decode_utf8 {
    if (@_) {
    Java::inline '
        String s = List__.shift().toString();
        char[] chars = s.toCharArray();
        byte[] bytes = new byte[chars.length];
        for (int i = 0; i < bytes.length(); i++){
            bytes[i] = (int)(chars[i]);
        }
        return new PlString(new String(bytes, "UTF-8"));
    ';
    }
    return undef;
}

1;

