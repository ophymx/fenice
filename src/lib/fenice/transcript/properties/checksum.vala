namespace Fenice {

public struct checksum_t {
    public string checksum;
    public bool check;
    public GLib.ChecksumType checksum_type;

    private const size_t BUFFER_SIZE = 524288;

    public checksum_t(string checksum, bool check = true,
        GLib.ChecksumType checksum_type = GLib.ChecksumType.SHA1) {
        this.checksum = checksum;
        this.check = check;
        this.checksum_type = checksum_type;
    }

    public checksum_t.from_file(string filename, bool check = true,
        GLib.ChecksumType checksum_type = GLib.ChecksumType.SHA1) {
        this.check = check;
        this.checksum_type = checksum_type;

        var digester = new GLib.Checksum(checksum_type);
        var buffer = new uchar[BUFFER_SIZE];
        var buf_len = BUFFER_SIZE;

        try {
            var file = GLib.File.new_for_path(filename);
            var stream = file.read();
            ssize_t read_len = 0;
            while ((read_len = stream.read(buffer)) > 0) {
                digester.update(buffer, (size_t) read_len);
            }
            stream.close();
        } catch(Error e) {
            stderr.printf("%s\n", e.message);
        }
        digester.get_digest(buffer, ref buf_len);
        checksum = Base64.encode(buffer[0:buf_len]);
    }

    public checksum_t.parse(string checksum) {
        if (checksum[0] == '-') {
            this.checksum = checksum.substring(1);
            check = false;
        } else {
            this.checksum = checksum;
            check = true;
        }
    }

    public bool equal(checksum_t other) {
        return (!check) | other.checksum == checksum;
    }

    public string to_string() {
        var builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(checksum);
        return builder.str;
    }
}

}
