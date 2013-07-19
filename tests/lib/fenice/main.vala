static const string ASSETS_DIR = "tests/assets";

int main(string[] args) {
    Test.init(ref args);
    TestSuite tests = TestSuite.get_root();

    tests.add_suite(new TranscriptFileTests().get_suite());
    tests.add_suite(new FswalkerTests().get_suite());

    return Test.run();
}
