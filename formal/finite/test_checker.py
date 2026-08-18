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
from gate8_compare import run_gate8_comparison
from gate8_anderson import validate_anderson_no_collapse_model
from gate8_frames import validate_anderson_s4_countermodel
from gate8_scott_frames import validate_scott_s4_countermodel
from gate8_fitting import validate_fitting_admissible_de_re_de_dicto_model
from gate8_fitting_no_collapse import validate_fitting_necessary_god_no_collapse_model
from gate8_fitting_minimality import (
    validate_neg_class_consistency_strictness,
    validate_positive_stability_strictness,
)
from gate8_fitting_comp import validate_indiscernibility_route_without_comp
from gate8_fitting_profile_saturation import validate_profile_saturation_route_without_comp
from gate8_fitting_algebra import validate_fde_algebra_does_not_force_profile_saturation
from gate8_fitting_entailment import (
    validate_entailment_closure_does_not_force_profile_saturation,
    validate_existence_saturation_is_needed_for_entailment_descent,
)
from gate8_fitting_rigidity_bridge import (
    validate_rigidity_bridge_exhaustive,
    validate_rplus_without_symmetry_does_not_force_persistence,
    validate_symmetry_without_rplus_does_not_force_reflection,
)
from gate8_fitting_converse_rigidity import (
    validate_bidirectional_rigidity_without_symmetry,
    validate_converse_rigidity_exhaustive,
    validate_converse_without_forward_does_not_force_reflection,
)
from gate8_fitting_actualist_quotient import (
    validate_actualist_profile_quotient,
    validate_actualist_quotient_requires_existence_factorization,
)
from gate10_quotient_delta_filters import validate_quotient_delta_filters
from gate11_paired_neighborhoods import validate_paired_neighborhoods


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
        self.assertEqual(retained, 873)
        self.assertEqual(
            set(witnesses),
            {"A1-L", "R+", "COMP_P^G", "CONS_G^G"},
        )

    def test_gate8_support_vs_exact_godlikeness(self):
        self.assertTrue(run_gate8_comparison())

    def test_gate8_anderson_bilateral_chain_without_modal_collapse(self):
        self.assertTrue(validate_anderson_no_collapse_model())

    def test_gate8_anderson_s4_without_symmetry_does_not_force_t3(self):
        self.assertTrue(validate_anderson_s4_countermodel())

    def test_gate8_scott_s4_without_symmetry_does_not_force_t3(self):
        self.assertTrue(validate_scott_s4_countermodel())

    def test_gate8_fitting_admissible_de_re_de_dicto_separation(self):
        self.assertTrue(validate_fitting_admissible_de_re_de_dicto_model())

    def test_gate8_fitting_necessary_god_without_modal_collapse(self):
        self.assertTrue(validate_fitting_necessary_god_no_collapse_model())

    def test_gate8_fitting_negative_class_consistency_is_strict_for_a1l_route(self):
        self.assertTrue(validate_neg_class_consistency_strictness())

    def test_gate8_fitting_positive_stability_is_strictly_weaker_than_bilateral(self):
        self.assertTrue(validate_positive_stability_strictness())

    def test_gate8_fitting_indiscernibility_route_bypasses_comp(self):
        self.assertTrue(validate_indiscernibility_route_without_comp())

    def test_gate8_fitting_profile_saturation_derives_indiscernibility_without_comp(self):
        self.assertTrue(validate_profile_saturation_route_without_comp())

    def test_gate8_fitting_fde_algebra_closure_does_not_force_profile_saturation(self):
        self.assertTrue(validate_fde_algebra_does_not_force_profile_saturation())

    def test_gate8_fitting_entailment_closure_does_not_force_profile_saturation(self):
        self.assertTrue(validate_entailment_closure_does_not_force_profile_saturation())

    def test_gate8_fitting_entailment_descent_needs_profile_existence_saturation(self):
        self.assertTrue(validate_existence_saturation_is_needed_for_entailment_descent())

    def test_gate8_fitting_rigidity_bridge_exhaustive(self):
        checked, r_plus_models, symmetric_r_plus_models = (
            validate_rigidity_bridge_exhaustive()
        )
        self.assertEqual(checked, 256)
        self.assertGreater(r_plus_models, 0)
        self.assertGreater(symmetric_r_plus_models, 0)

    def test_gate8_fitting_rplus_without_symmetry_does_not_force_persistence(self):
        self.assertTrue(
            validate_rplus_without_symmetry_does_not_force_persistence()
        )

    def test_gate8_fitting_symmetry_without_rplus_does_not_force_reflection(self):
        self.assertTrue(validate_symmetry_without_rplus_does_not_force_reflection())

    def test_gate8_fitting_converse_rigidity_derives_persistence_exhaustively(self):
        self.assertEqual(
            validate_converse_rigidity_exhaustive(),
            (256, 152, 112, 80, 32),
        )

    def test_gate8_fitting_bidirectional_rigidity_does_not_require_symmetry(self):
        self.assertTrue(validate_bidirectional_rigidity_without_symmetry())

    def test_gate8_fitting_converse_rigidity_alone_does_not_force_reflection(self):
        self.assertTrue(
            validate_converse_without_forward_does_not_force_reflection()
        )

    def test_gate8_actualist_profile_quotient_preserves_entailment_and_fde_values(self):
        self.assertTrue(validate_actualist_profile_quotient())

    def test_gate8_actualist_quotient_requires_existence_factorization(self):
        self.assertTrue(
            validate_actualist_quotient_requires_existence_factorization()
        )

    def test_gate10_quotient_delta_filter_audit(self):
        counts = validate_quotient_delta_filters()
        self.assertEqual(counts["delta_filters"], 15)
        self.assertEqual(counts["prime_delta_filters"], 4)
        self.assertEqual(counts["nondeciding_prime_delta_filters"], 4)

    def test_gate11_paired_neighborhood_bridge(self):
        counts = validate_paired_neighborhoods()
        self.assertEqual(counts["local_frames"], 256)
        self.assertEqual(counts["complement_dual_frames"], 16)
        self.assertEqual(counts["principal_relational_frames"], 4)
        self.assertEqual(counts["nonprincipal_complement_dual_frames"], 12)
        self.assertEqual(counts["relational_operator_checks"], 1024)
        self.assertEqual(counts["arbitrary_classical_outputs"], 4)


if __name__ == "__main__":
    unittest.main()
