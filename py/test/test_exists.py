# ProjectName SDK exists test

import pytest
from iseven_sdk import IsEvenSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = IsEvenSDK.test(None, None)
        assert testsdk is not None
