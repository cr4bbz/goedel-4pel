import unittest

from checker import (
    Val,
    exhaustive_mc_schema_equivalence_two_world_s5,
    exhaustive_reg_g_implies_t2,
    t2_gap_countermodel,
    t2_glut_countermodel,
)


class Gate7Tests(unittest.TestCase):
    def test_negation_is_involutive(self):
        for v in Val:
            self.assertEqual(v.negate().negate(), v)

    def test_glut_countermodel(self):
        m = t2_glut_countermodel()
        self.assertTrue(m.control_stack())
        self.assertFalse(m.t2_plus())
        self.assertTrue(m.comp_p_g())
        self.assertFalse(m.cons_g_g())

    def test_gap_countermodel(self):
        m = t2_gap_countermodel()
        self.assertTrue(m.control_stack())
        self.assertFalse(m.t2_plus())
        self.assertTrue(m.cons_g_g())
        self.assertFalse(m.comp_p_g())

    def test_mc_schema_equivalence_exhaustive_two_world_s5(self):
        self.assertEqual(exhaustive_mc_schema_equivalence_two_world_s5(), 16)

    def test_reg_g_implies_t2_in_small_search_space(self):
        checked = exhaustive_reg_g_implies_t2()
        self.assertEqual(checked, 204)


if __name__ == "__main__":
    unittest.main()
