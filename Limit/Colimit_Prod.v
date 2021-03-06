Require Import Basics Types MyLemmas Diagram Colimit Colimit_Sigma MyTacs.

Context `{Funext}.

Section ColimitProd.
  Context {G: graph} (D: diagram G) (A: Type).

  Definition prod_diag : diagram G.
    simple refine (Build_diagram _ _ _).
    exact (λ i, A * (D i)).
    simpl; intros i j f x. exact (fst x, D _f f (snd x)).
  Defined.

  Definition diagram_map_prod_sigma : diagram_map (sigma_diag (λ _:A, D)) prod_diag.
    simple refine (Build_diagram_map _ _).
    exact (λ i x, (x.1, x.2)).
    reflexivity.
  Defined.
 
  Lemma is_colimit_prod {Q: Type} (HQ: is_colimit D Q)
  : is_colimit prod_diag (A * Q).
    simple refine (postcompose_equiv_is_colimit (Q := sig (λ _:A, Q)) _ _).
    apply equiv_sigma_prod0.
    simple refine (precompose_equiv_is_colimit (D2 := sigma_diag (λ _:A, D)) _ _). {
      simple refine (Build_diagram_equiv _ _).
      - simple refine (Build_diagram_map _ _).
        intros i. apply equiv_sigma_prod0.
        reflexivity.
      - intros i. simpl.
        simple refine (isequiv_inverse (equiv_sigma_prod0 A (D i))). }
    simple refine (is_colimit_sigma _ _). intros; exact HQ.
  Defined.
End ColimitProd.




(*  *)