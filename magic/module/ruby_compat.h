/* ruby_compat.h
 * Macros to make ruby1.8 look like ruby1.9.
 * Copyright 2010 Thoughtgang <http://www.thoughtgang.org>
 * Written by TG Community Developers <community@thoughtgang.org>
 * Released under the GNU Public License, version 3.
 * See http://www.gnu.org/licenses/gpl.txt for details.
 */

#ifndef RUBY_COMPAT_H
#define RUBY_COMPAT_H

#ifdef RUBY_18
#include <stdarg.h>
#define rb_str_new_cstr(arg) rb_str_new2(arg)

VALUE Magic_rb_hash_lookup2(VALUE, VALUE, VALUE);
#define rb_hash_lookup2( a1, a2, a3 ) Magic_rb_hash_lookup2(a1, a2, a3)

#endif
#endif
