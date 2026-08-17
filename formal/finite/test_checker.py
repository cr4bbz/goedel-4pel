import unittest

from checker import (
    Val,
    exhaustive_mc_schema_equivalence_two_world_s5,
    exhaustive_reg_g_implies_t2,
    t2_gap_countermodel,
    t2_glut_countermodel,
)
from gate7_search import (
    exhaustive_t2_assumption_minimality,
    validate_t1_glut_countermodel,
)


class Gate7Tests(unittest.TestCase):
    def test_negation_is_involutive(self):
        for v in Val:
            self.assertEqual(v.negate().negate(), v)

    def test_t1_unrestricted_positive_glut_countermodel(self):
        self.assertTrue(validate_t1_glut_countermodel())

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

    def test_t2_recovery_assumptions_are_individually_needed_in_bounded_family(self):
        retained, witnesses = exhaustive_t2_assumption_minimality()
        self.assertEqual(retained, 1753)
        self.assertEqual(
            set(witnesses),
            {"A1-L", "R+", "COMP_P^G", "CONS_G^G"},
        )


if __name__ == "__main__":
    unittest.main()
