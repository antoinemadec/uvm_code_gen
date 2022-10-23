  foreach ({var}[i])
    result &= comparer.compare_field("{var}", {var}[i], rhs_.{var}[i], $bits({var}[i]));
