namespace Fenice {

public class NegativeTranscript : Object, Transcript {

    private Transcript transcript;

    public NegativeTranscript(Transcript transcript) {
        this.transcript = transcript;
    }

    public TranscriptIterator iterator() {
        return new NegativeTranscriptIterator(transcript.iterator());
    }
}

public class NegativeTranscriptIterator : Object, TranscriptIterator {

    private TranscriptIterator transcript_iter;
    private TranscriptEntryConverter negative_converter =
        new NegativeConverter();

    public NegativeTranscriptIterator(TranscriptIterator transcript_iter) {
        this.transcript_iter = transcript_iter;
    }

    public bool next() {
        return transcript_iter.next();
    }

    public new TranscriptEntry get() {
        return negative_converter.convert(transcript_iter.get());
    }
}

}
