namespace Fenice {

public struct path_t {

    public string path;
    public bool case_sensitive;

    public path_t(string path, bool case_sensitive=true) {
        this.path = path;
        this.case_sensitive = case_sensitive;
    }

    public path_t.parse(string path, bool case_sensitive=true) {
        this.path = path.compress();
        this.case_sensitive = case_sensitive;
    }

    public bool equal(path_t other) {
        return compare_to(other) == 0;
    }

    public int compare_to(path_t other) {
        string a;
        string b;
        if (case_sensitive) {
            a = path;
            b = other.path;
        } else {
            a = path.casefold();
            b = other.path.casefold();
        }
        long i = 0;

        while (i < a.length & i < b.length) {
            if (a[i] != b[i]) {
                if (a[i] == '/')
                    return -1;
                if (b[i] == '/')
                    return 1;
                return (a[i] < b[i]) ? -1 : 1;
            }
            i++;
        }
        if (a.length == b.length)
            return 0;
        return (a.length < b.length) ? -1 : 1;
    }

    public string to_string() {
        return path.escape("").replace(" ", "\\b");
    }

}

}
