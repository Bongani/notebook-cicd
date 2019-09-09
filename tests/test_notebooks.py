import sys
import papermill as pm
import scrapbook as sb
import pytest
import pandas as pd
import seaborn as sns

from pandas.util.testing import assert_almost_equal


@pytest.fixture()
def common_kwargs(tmpdir):
    outputnb = "outputs/demo-iris-dataset.ipynb"
    return {
        'output_path': str(outputnb),
        'kernel_name': 'python{}'.format(sys.version_info.major),
    }

def test_demo_iris_dataset(common_kwargs):
    pm.execute_notebook(
        'notebooks/demo-iris-dataset.ipynb',
        parameters={'validation_datadir': 'validation/data'},
        **common_kwargs
    )
    nb = sb.read_notebook(common_kwargs['output_path'])

    actual = pd.DataFrame(nb.scraps['data_df'].data)[['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'species']]
    expected = sns.load_dataset('iris')
    assert_almost_equal(actual, expected)
