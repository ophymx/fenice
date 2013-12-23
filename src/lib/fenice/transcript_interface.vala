namespace Fenice {

public interface Transcript : Object {
    public static Transcript empty() {
        return new TranscriptContainer.empty();
    }

    public abstract TranscriptIterator iterator();
}

public interface TranscriptIterator : Object {

    public abstract bool next();
    public abstract TranscriptEntry get();
}

}
