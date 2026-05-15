# IsEven SDK utility: make_context

from core.context import IsEvenContext


def make_context_util(ctxmap, basectx):
    return IsEvenContext(ctxmap, basectx)
