namespace Fenice {

public class BlockPresenter : Object {
    public string present(Tblock block) {
        var builder = new StringBuilder(block.was_removed() ? "- " : "");
        builder.append_printf("b %-35s\t%s %5s %5s %5d %5d",
            block.path.to_string(),
            block.mode.to_string(),
            block.uid.to_string(),
            block.gid.to_string(),
            block.major,
            block.minor
        );
        return builder.str;
    }
}

public class CharPresenter : Object {
    public string present(Tchar char_dev) {
        var builder = new StringBuilder(char_dev.was_removed() ? "- " : "");
        builder.append_printf("c %-35s\t%s %5s %5s %5d %5d",
            char_dev.path.to_string(),
            char_dev.mode.to_string(),
            char_dev.uid.to_string(),
            char_dev.gid.to_string(),
            char_dev.major,
            char_dev.minor
        );
        return builder.str;
    }
}

public class DirPresenter : Object {
    public string present(Tdir dir) {
        var builder = new StringBuilder(dir.was_removed() ? "- " : "");
        builder.append_printf("d %-35s\t%s %5s %5s",
            dir.path.to_string(),
            dir.mode.to_string(),
            dir.uid.to_string(),
            dir.gid.to_string()
        );
        return builder.str;
    }
}

public class FilePresenter : Object {
    public string present(Tfile file) {
        var builder = new StringBuilder(file.was_removed() ? "- " : "");
        builder.append_printf("f %-35s\t%s %5s %5s %9s %7s %s",
            file.path.to_string(),
            file.mode.to_string(),
            file.uid.to_string(),
            file.gid.to_string(),
            file.mtime.to_string(),
            file.size.to_string(),
            file.checksum.to_string()
        );
        return builder.str;
    }
}

public class LinkPresenter : Object {
    public string present(Tlink link) {
        var builder = new StringBuilder(link.was_removed() ? "- " : "");
        builder.append_printf("h %-35s\t%s",
            link.path.to_string(),
            link.target.to_string()
        );
        return builder.str;
    }
}

public class SymlinkPresenter : Object {
    public string present(Tsymlink symlink) {
        var builder = new StringBuilder(symlink.was_removed() ? "- " : "");
        builder.append_printf("f %-35s\t%s %5s %5s %s",
            symlink.path.to_string(),
            symlink.mode.to_string(),
            symlink.uid.to_string(),
            symlink.gid.to_string(),
            symlink.target.to_string()
        );
        return builder.str;
    }
}

public class PipePresenter : Object {
    public string present(Tpipe pipe) {
        var builder = new StringBuilder(pipe.was_removed() ? "- " : "");
        builder.append_printf("p %-35s\t%s %5s %5s",
            pipe.path.to_string(),
            pipe.mode.to_string(),
            pipe.uid.to_string(),
            pipe.gid.to_string()
        );
        return builder.str;
    }
}

public class SocketPresenter : Object {
    public string present(Tsocket socket) {
        var builder = new StringBuilder(socket.was_removed() ? "- " : "");
        builder.append_printf("s %-35s\t%s %5s %5s",
            socket.path.to_string(),
            socket.mode.to_string(),
            socket.uid.to_string(),
            socket.gid.to_string()
        );
        return builder.str;
    }
}

}
