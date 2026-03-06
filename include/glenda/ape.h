#ifndef _GLENDA_APE_H
#define _GLENDA_APE_H

extern long __libape_syscall_dispatch(long, long, long, long, long, long, long);
extern void __libape_init(void);

static inline long
__syscall0(long n)
{
    return __libape_syscall_dispatch(n, 0, 0, 0, 0, 0, 0);
}

static inline long __syscall1(long n, long a)
{
    return __libape_syscall_dispatch(n, a, 0, 0, 0, 0, 0);
}

static inline long __syscall2(long n, long a, long b)
{
    return __libape_syscall_dispatch(n, a, b, 0, 0, 0, 0);
}

static inline long __syscall3(long n, long a, long b, long c)
{
    return __libape_syscall_dispatch(n, a, b, c, 0, 0, 0);
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    return __libape_syscall_dispatch(n, a, b, c, d, 0, 0);
}

static inline long __syscall5(long n, long a, long b, long c, long d, long e)
{
    return __libape_syscall_dispatch(n, a, b, c, d, e, 0);
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    return __libape_syscall_dispatch(n, a, b, c, d, e, f);
}

#endif