namespace Fenice {

public interface Transcript : Object {

    public abstract TranscriptIterator iterator();
}

public interface TranscriptIterator : Object {

    public abstract bool next();
    public abstract TranscriptEntry get();
}

}
