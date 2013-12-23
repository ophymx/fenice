static const string ASSETS_DIR = "tests/assets";

int main(string[] args) {
    Test.init(ref args);
    TestSuite tests = TestSuite.get_root();

    tests.add_suite(new TranscriptFileTests().get_suite());
    tests.add_suite(new PosixFilesystemTests().get_suite());
    tests.add_suite(new CompositeTranscriptTests().get_suite());

    TestSuite property_tests = new TestSuite("Transcript Property");
    property_tests.add_suite(new checksum_tTests().get_suite());
    property_tests.add_suite(new gid_tTests().get_suite());
    property_tests.add_suite(new mode_tTests().get_suite());
    property_tests.add_suite(new mtime_tTests().get_suite());
    property_tests.add_suite(new path_tTests().get_suite());
    property_tests.add_suite(new size_tTests().get_suite());
    property_tests.add_suite(new target_tTests().get_suite());
    property_tests.add_suite(new uid_tTests().get_suite());

    tests.add_suite(property_tests);

    return Test.run();
}
