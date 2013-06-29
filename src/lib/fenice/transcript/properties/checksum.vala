namespace Fenice {

public struct Tchecksum {
    public string checksum;
    public bool check;
    public GLib.ChecksumType checksum_type;

    private const uint BUFFER_SIZE = 524288;

    public Tchecksum(string checksum, bool check = true,
        GLib.ChecksumType checksum_type = GLib.ChecksumType.SHA1) {
        this.checksum = checksum;
        this.check = check;
        this.checksum_type = checksum_type;
    }

    public Tchecksum.from_file(string filename, bool check = true,
        GLib.ChecksumType checksum_type = GLib.ChecksumType.SHA1) {
        this.check = check;
        this.checksum_type = checksum_type;

        GLib.Checksum digester = new GLib.Checksum(checksum_type);
        uchar[] buffer = new uchar[BUFFER_SIZE];
        size_t buf_len = BUFFER_SIZE;

        try {
            GLib.File file = GLib.File.new_for_path(filename);
            FileInputStream stream = file.read();
            //FileStream stream = FileStream.open (filename, "rb");
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

    public Tchecksum.parse(string checksum) {
        if (checksum[0] == '-') {
            this.checksum = checksum.substring(1);
            check = false;
        } else {
            this.checksum = checksum;
            check = true;
        }
    }

    public bool equal(Tchecksum other) {
        return (!check) | other.checksum == checksum;
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(checksum);
        return builder.str;
    }
}

}
