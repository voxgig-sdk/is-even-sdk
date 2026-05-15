# IsEven SDK feature factory

from feature.base_feature import IsEvenBaseFeature
from feature.test_feature import IsEvenTestFeature


def _make_feature(name):
    features = {
        "base": lambda: IsEvenBaseFeature(),
        "test": lambda: IsEvenTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
