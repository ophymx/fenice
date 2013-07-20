namespace Fenice {

public struct uid_t {

    public uint uid;
    public bool check;

    public uid_t(uint uid, bool check=true) {
        this.uid = uid;
        this.check = check;
    }

    public uid_t.parse(string uid) {
        if (uid[0] == '-') {
            uid.substring(1).scanf("%u", out this.uid);
            check = false;
        } else {
            uid.scanf("%u", out this.uid);
            check = true;
        }
    }

    public bool equal(uid_t other) {
        return (!check) | uid == other.uid;
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        if (!check)
            builder.append("-");
        builder.append_printf("%u", (uint) uid);
        return builder.str;
    }
}

}
