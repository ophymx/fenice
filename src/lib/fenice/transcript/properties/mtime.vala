namespace Fenice {

public struct mtime_t {

    public time_t mtime;
    public bool check;

    public mtime_t(time_t mtime, bool check = true) {
        this.mtime = mtime;
        this.check = check;
    }

    public mtime_t.parse(string mtime) {
        if (mtime[0] == '-') {
            this.mtime = (time_t) uint64.parse(mtime.substring(1));
            check = false;
        } else {
            this.mtime = (time_t) uint64.parse(mtime);
            check = true;
        }
    }

    public bool equal(mtime_t other) {
        return (!check) | mtime == other.mtime;
    }

    public int compare_to(mtime_t other) {
        return (int) (other.mtime - mtime);
    }

    public string to_string() {
        var builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(((uint64) mtime).to_string());
        return builder.str;
    }
}

}
