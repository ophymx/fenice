namespace Fenice {

public struct Tgid {

    public uint gid;
    public bool check;

    public class Tgid(uint gid, bool check=true) {
        this.gid = gid;
        this.check = check;
    }

    public class Tgid.parse(string gid) {
        if (gid[0] == '-') {
            gid.substring(1).scanf("%u", out this.gid);
            check = false;
        } else {
            gid.scanf("%u", out this.gid);
            check = true;
        }
    }

    public bool equal(Tgid other) {
        return (!check) | gid == other.gid;
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(gid.to_string());
        return builder.str;
    }
}

}
