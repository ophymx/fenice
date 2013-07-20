namespace Fenice {

public struct fsize_t {

    public size_t size;
    public bool check;

    public fsize_t(size_t size, bool check=true) {
        this.size = size;
        this.check = check;
    }

    public fsize_t.parse(string size) {
        if (size[0] == '-') {
            this.size = (size_t)uint64.parse(size.substring(1));
            check = false;
        } else {
            this.size = (size_t)uint64.parse(size);
            check = true;
        }
    }

    public bool equal(fsize_t other) {
        return (!check) | size == other.size;
    }

    public int compare_to(fsize_t other) {
        return (int)(other.size - size);
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(size.to_string());
        return builder.str;
    }
}

}
