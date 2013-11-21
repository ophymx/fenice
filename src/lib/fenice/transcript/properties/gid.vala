namespace Fenice {

public struct gid_t {

    public uint gid;
    public bool check;

    public class gid_t(uint gid, bool check=true) {
        this.gid = gid;
        this.check = check;
    }

    public class gid_t.parse(string gid) {
        if (gid[0] == '-') {
            gid.substring(1).scanf("%u", out this.gid);
            check = false;
        } else {
            gid.scanf("%u", out this.gid);
            check = true;
        }
    }

    public bool equal(gid_t other) {
        return (!check) | gid == other.gid;
    }

    public string to_string() {
        var builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(gid.to_string());
        return builder.str;
    }
}

}
