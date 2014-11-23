    SEARCH_RANGE(A, l, u)
    for elm in A:
        if elm > l and elm < u:
            return True

    return False
