public class FwalkerTests : Gee.TestCase {

    public FwalkerTests() {
        base("Fswalker");

    }

}

public class FakefsReader : Object , FilesystemReader {

    public FakefsReader() {
    }

    public Tobject read(string path, Gee.Map<ulong, Tpath?> inodes) {
    }

    public Gee.Iterable<string> get_directory_entries(string dirname) {
    }

}


public class FwalkerIteratorTests : Gee.TestCase {

    public FwalkerIteratorTests() {
        base("FswalkerIterator");
        add_test("", () => {
            var walker = new Fenice.FswalkerIterator("./foo", new FakefsReader());
        });
    }

}
