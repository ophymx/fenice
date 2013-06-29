namespace Fenice {

public struct Tsize {

    public size_t size;
    public bool check;

    public Tsize(size_t size, bool check=true) {
        this.size = size;
        this.check = check;
    }

    public Tsize.parse(string size) {
        if (size[0] == '-') {
            this.size = (size_t)uint64.parse(size.substring(1));
            check = false;
        } else {
            this.size = (size_t)uint64.parse(size);
            check = true;
        }
    }

    public bool equal(Tsize other) {
        return (!check) | size == other.size;
    }

    public int compare_to(Tsize other) {
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
