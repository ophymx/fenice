namespace Fenice {

public struct mode_t {

    /**
     * File Permission bit mask 0777 OR 4095
     * Posix.S_ISUID | Posix.S_ISGID | Posix.S_ISVTX |
     *     Posix.S_IRWXU | Posix.S_IRWXG | Posix.S_IRWXO;
     */
    public static const uint PERM_MASK = 4095;

    public uint mode;
    public uint mask;

    public mode_t(uint mode, uint mask=0) {
        this.mode = mode;
        this.mask = mask ^ PERM_MASK;
    }

    public mode_t.parse(string mode_mask_str) {
        uint mode = 493;
        uint mask = 0;
        if (mode_mask_str.length == 9) {
            if (mode_mask_str[4] == '-') {
                mode_mask_str.scanf("%o-%o", out mode, out mask);
            }
        } else {
            mode_mask_str.scanf("%o", out mode);
        }
        this.mode = mode;
        this.mask = (mask) ^ PERM_MASK;
    }

    public bool equal(mode_t other) {
        return (mode & mask) == (other.mode & other.mask);
    }

    public uint get_chmod(uint current) {
        return (current & (mask ^ PERM_MASK)) | (mode & mask);
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        builder.append_printf("%04o", (uint)mode);
        if (mask != PERM_MASK)
            builder.append_printf("-%04o", (uint)(mask ^ PERM_MASK));
        return builder.str;
    }
}

}
