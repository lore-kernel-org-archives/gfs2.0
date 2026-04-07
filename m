Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0C38AC93
	for <gfs2@lists.linux.dev>; Tue,  7 Apr 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553376; cv=none; b=ll0GoolJRjHelclTkTiZIAi6U76UZFCvxVvMOHjGbvV3yUEnsXsaWaPp8Yaa1OkE2xb9rK5b4iFdLYviQkITEZfZuowLrBS9Oni7Pe7T/msLRBDmD/4I7hCVh32oFjYu1/FSwhp1V7zzsSeL8BNeLtd4Qg32NTbzQxPFI+xyvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553376; c=relaxed/simple;
	bh=o3i6JFub4e3qyNYBk0Kkg7NEpFv0UFtok8atguGjMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G90iIqzjpYwIyY3lHUS1uPoWWWwH4iyhMk/XQ+Y9beDCvRn4no7c2mJBLE3fARfJh6IKzMip0kHLLtckYVDlpoe48dY0bTdKkRrzFGguzjqRh6pEgv7Bd1fqz2CzZXH3v2miOYZxm7oWkpytvwyKvCFL6bk8qWyIEYrUn+491GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1cEXtRy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1cEXtRy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso17685325e9.1
        for <gfs2@lists.linux.dev>; Tue, 07 Apr 2026 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775553374; x=1776158174; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRZwJ4olEKPGoXuLhtiI8SpquRIE0O1w/SAx2efsTRY=;
        b=C1cEXtRyT51rEqGpdLXclC8t7AI7EOyQ++58PnTDJYFHzm/5PLiRKOki1Xnp+TWbhw
         DZ5N8lQ/nPoQW8XztlfnVzK6M6WZHGg91XBAcr2+t9Ewu+zyc0HXVk1oNp2GroIA/G5V
         8TP9Td3bTYVgVFpg2OAl16Mfeu6W7nKb2y+6NWogpd4F2oWisMwKTUGepHv9r29a7Ybl
         duKiDjXNoD0jAIwLtlsjYB9y6hMtrf+QflWURltah6Oqiv6zWeqwQMVGfTJY7HhGV2SE
         jE1KviKQtj4UcWiHRA5RHjdihfd0OObqK7vCF5DDIyO/i7ePiXoPeSC5bcVTp9+cBt1O
         UOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553374; x=1776158174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRZwJ4olEKPGoXuLhtiI8SpquRIE0O1w/SAx2efsTRY=;
        b=XRoCUJjQkSOyUWn2WjQkpxAv+kig2/lZ8Rm6cq2/DS+bzdNzOQev1wqTb83GiQUoym
         CCY/INpIyRG/IsR7wmfxAsg9MN00S0eZ3qDhGv0Du4SoqFaUtd0Wqu2FX9/4HU8lFyeJ
         hPBN9fG82SNvPx2qaAIiSYjS9owi8qlVRtvIJI3DtmdCg5EQOcRnT3UMEFQ2DEHAsiDu
         ES2r46GuHUtqw75zhDxd5EFclCwiOCutRET/yWim/FnzzSKWv+QMbA8dBv8BonxoH/8Q
         Cr4wHagRdQjErchLDEp2WRTzdJcbhKlwupVx0p/eDDwyyXP7r3uPm4bCZi7GdRnbUs3F
         SSCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7bsRy2CHj8bKo5zjFdHrWQSmbqls8G3LFd+0A0FaA81kS3pnthy/ejsUMnn2NLFVv/yJ5@lists.linux.dev
X-Gm-Message-State: AOJu0YyAAF0l0ETWKSYawX1KpaCKYIzSkLFXnl3b+QyqJyL5QqNuMST+
	nZPq7zTNU8sBRdT1zyijkk8g+xiOvvdSPGJRPW0dUmI4pnMMK9ckgsTD
X-Gm-Gg: AeBDieti9nASYuuMwCZbfdcsWSUhJGPHf2wI+XJ04jnNg/cSOd+6TRxd31BLktpixaT
	k5ePUAhjKfqijjlTblbQ9u5ZF4xXd6d+oe+HQMgSx5CXbAmejO38c4AjfpZbBBdlXCQxsoDqISC
	mCQ0OOyBxnN3xKjXYWBpvuJhgff68j2ENW4KFy6jOcCy4jpgKTNEaKgwR36C+C/OPKku6FvOdgi
	+HnbNO2c+yM9iE1JxNHjlnOffUiSEnSE1RCeDCm+KGt8yU63NPlwlUqUm46CFyC2XksYFsj0Cu2
	Vz9Ixg/NRslc2xN5iPYY6i7F4mIu0+7oRb8maOFD+AMFjnGT+vWqmV9OOv4GjqJ6bN5g8RB8ggW
	4UsOArqhQR6hqgAuPeNGcsxkQFnNBSPkUNlMNSpscejk3gvIWjj5OQWsIZxusmaNGXdYGxq7XEq
	GtHfVU5kbuDJGJ9YFdzL4EJkFs9we7ww==
X-Received: by 2002:a05:600c:a30a:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4889949bd2dmr155372815e9.11.1775553373248;
        Tue, 07 Apr 2026 02:16:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a4b2e111sm275137475e9.1.2026.04.07.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:16:12 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:16:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:for-next 13/17] fs/gfs2/log.c:1183 __gfs2_log_flush() error:
 we previously assumed 'sdp->sd_jdesc' could be null (see line 1136)
Message-ID: <202604071139.HNJiCaAi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   80d71795c17ec98352d1059af856ac084a06109a
commit: 47af62bd5b63da799ea51f53ff93b5f1a3d19046 [13/17] gfs2: add some missing log locking
config: csky-randconfig-r071-20260406 (https://download.01.org/0day-ci/archive/20260407/202604071139.HNJiCaAi-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202604071139.HNJiCaAi-lkp@intel.com/

New smatch warnings:
fs/gfs2/log.c:1183 __gfs2_log_flush() error: we previously assumed 'sdp->sd_jdesc' could be null (see line 1136)

vim +1183 fs/gfs2/log.c

47af62bd5b63da Andreas Gruenbacher 2026-03-31  1065  static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
47af62bd5b63da Andreas Gruenbacher 2026-03-31  1066  			     u32 flags)
b3b94faa5fe596 David Teigland      2006-01-16  1067  {
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1068  	struct gfs2_trans *tr = NULL;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1069  	unsigned int reserved_blocks = 0, used_blocks = 0;
5432af15f8772d Andreas Gruenbacher 2022-08-18  1070  	bool frozen = test_bit(SDF_FROZEN, &sdp->sd_flags);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1071  	unsigned int first_log_head;
2129b4288852cf Andreas Gruenbacher 2020-12-17  1072  	unsigned int reserved_revokes = 0;
b3b94faa5fe596 David Teigland      2006-01-16  1073  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1074  	trace_gfs2_log_flush(sdp, 1, flags);
b3b94faa5fe596 David Teigland      2006-01-16  1075  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1076  repeat:
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1077  	/*
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1078  	 * Do this check while holding the log_flush_lock to prevent new
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1079  	 * buffers from being added to the ail via gfs2_pin()
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1080  	 */
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1081  	if (gfs2_withdrawn(sdp) ||
4d927b03a68846 Andreas Gruenbacher 2023-12-20  1082  	    !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1083  		goto out;
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1084  
2bcd610d2fdea6 Steven Whitehouse   2007-11-08  1085  	/* Log might have been flushed while we waited for the flush lock */
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1086  	if (gl && !test_bit(GLF_LFLUSH, &gl->gl_flags))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1087  		goto out;
f55ab26a8f92a2 Steven Whitehouse   2006-02-21  1088  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1089  	first_log_head = sdp->sd_log_head;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1090  	sdp->sd_log_flush_head = first_log_head;
400ac52e805bb6 Benjamin Marzinski  2015-12-09  1091  
16ca9412d80181 Benjamin Marzinski  2013-04-05  1092  	tr = sdp->sd_log_tr;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1093  	if (tr || sdp->sd_log_num_revoke) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1094  		if (reserved_blocks)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1095  			gfs2_log_release(sdp, reserved_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1096  		reserved_blocks = sdp->sd_log_blks_reserved;
2129b4288852cf Andreas Gruenbacher 2020-12-17  1097  		reserved_revokes = sdp->sd_log_num_revoke;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1098  		if (tr) {
16ca9412d80181 Benjamin Marzinski  2013-04-05  1099  			sdp->sd_log_tr = NULL;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1100  			tr->tr_first = first_log_head;
5432af15f8772d Andreas Gruenbacher 2022-08-18  1101  			if (unlikely(frozen)) {
8daf6c2b3d8cee Andreas Gruenbacher 2025-08-05  1102  				if (gfs2_assert_withdraw(sdp,
ca399c96e96e3f Bob Peterson        2020-01-08  1103  				       !tr->tr_num_buf_new && !tr->tr_num_databuf_new))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1104  					goto out_withdraw;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1105  			}
2129b4288852cf Andreas Gruenbacher 2020-12-17  1106  		}
fe3e397668775e Andreas Gruenbacher 2020-12-10  1107  	} else if (!reserved_blocks) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1108  		unsigned int taboo_blocks = GFS2_LOG_FLUSH_MIN_BLOCKS;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1109  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1110  		reserved_blocks = GFS2_LOG_FLUSH_MIN_BLOCKS;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1111  		if (current == sdp->sd_logd_process)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1112  			taboo_blocks = 0;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1113  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1114  		if (!__gfs2_log_try_reserve(sdp, reserved_blocks, taboo_blocks)) {
fe3e397668775e Andreas Gruenbacher 2020-12-10  1115  			up_write(&sdp->sd_log_flush_lock);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1116  			__gfs2_log_reserve(sdp, reserved_blocks, taboo_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1117  			down_write(&sdp->sd_log_flush_lock);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1118  			goto repeat;
fe3e397668775e Andreas Gruenbacher 2020-12-10  1119  		}
2129b4288852cf Andreas Gruenbacher 2020-12-17  1120  		BUG_ON(sdp->sd_log_num_revoke);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1121  	}
fe3e397668775e Andreas Gruenbacher 2020-12-10  1122  
fe3e397668775e Andreas Gruenbacher 2020-12-10  1123  	if (flags & GFS2_LOG_HEAD_FLUSH_SHUTDOWN)
fe3e397668775e Andreas Gruenbacher 2020-12-10  1124  		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
f55ab26a8f92a2 Steven Whitehouse   2006-02-21  1125  
5432af15f8772d Andreas Gruenbacher 2022-08-18  1126  	if (unlikely(frozen))
8daf6c2b3d8cee Andreas Gruenbacher 2025-08-05  1127  		if (gfs2_assert_withdraw(sdp, !reserved_revokes))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1128  			goto out_withdraw;
b3b94faa5fe596 David Teigland      2006-01-16  1129  
d7b616e252b125 Steven Whitehouse   2007-09-02  1130  	gfs2_ordered_write(sdp);
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1131  	if (gfs2_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1132  		goto out_withdraw;
d69a3c6561362a Steven Whitehouse   2014-02-21  1133  	lops_before_commit(sdp, tr);
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1134  	if (gfs2_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1135  		goto out_withdraw;
35264909e9d197 Andreas Gruenbacher 2024-03-11 @1136  	if (sdp->sd_jdesc)
                                                            ^^^^^^^^^^^^^
Here the code assumes that sdp->sd_jdesc can be NULL.

4a94f052e09827 Andreas Gruenbacher 2025-12-11  1137  		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1138  	if (gfs2_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1139  		goto out_withdraw;
d7b616e252b125 Steven Whitehouse   2007-09-02  1140  
34cc1781c2ae92 Steven Whitehouse   2012-03-09  1141  	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
c1696fb85d3319 Bob Peterson        2018-01-17  1142  		log_write_header(sdp, flags);
5cb738b5fbd2f3 Andreas Gruenbacher 2020-12-19  1143  	} else if (sdp->sd_log_tail != sdp->sd_log_flush_tail && !sdp->sd_log_idle) {
c1696fb85d3319 Bob Peterson        2018-01-17  1144  		log_write_header(sdp, flags);
2332c4435bb733 Robert Peterson     2007-06-18  1145  	}
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1146  	if (gfs2_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1147  		goto out_withdraw;
16ca9412d80181 Benjamin Marzinski  2013-04-05  1148  	lops_after_commit(sdp, tr);
b09e593d799560 Steven Whitehouse   2006-04-07  1149  
5a15907f99e5d9 Andreas Gruenbacher 2026-03-20  1150  	spin_lock(&sdp->sd_log_lock);
faa31ce85f626d Steven Whitehouse   2006-09-13  1151  	sdp->sd_log_blks_reserved = 0;
b3b94faa5fe596 David Teigland      2006-01-16  1152  
d6a079e82efd5f Dave Chinner        2011-03-11  1153  	spin_lock(&sdp->sd_ail_lock);
16ca9412d80181 Benjamin Marzinski  2013-04-05  1154  	if (tr && !list_empty(&tr->tr_ail1_list)) {
16ca9412d80181 Benjamin Marzinski  2013-04-05  1155  		list_add(&tr->tr_list, &sdp->sd_ail1_list);
16ca9412d80181 Benjamin Marzinski  2013-04-05  1156  		tr = NULL;
b3b94faa5fe596 David Teigland      2006-01-16  1157  	}
d6a079e82efd5f Dave Chinner        2011-03-11  1158  	spin_unlock(&sdp->sd_ail_lock);
5a15907f99e5d9 Andreas Gruenbacher 2026-03-20  1159  	spin_unlock(&sdp->sd_log_lock);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1160  
c1696fb85d3319 Bob Peterson        2018-01-17  1161  	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
24972557b12ce8 Benjamin Marzinski  2014-05-01  1162  		if (!sdp->sd_log_idle) {
d5dc3d9677394d Bob Peterson        2020-05-22  1163  			empty_ail1_list(sdp);
1b7d498dcab489 Andreas Gruenbacher 2025-08-06  1164  			if (gfs2_withdrawn(sdp))
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1165  				goto out_withdraw;
c1696fb85d3319 Bob Peterson        2018-01-17  1166  			log_write_header(sdp, flags);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1167  		}
c1696fb85d3319 Bob Peterson        2018-01-17  1168  		if (flags & (GFS2_LOG_HEAD_FLUSH_SHUTDOWN |
c1696fb85d3319 Bob Peterson        2018-01-17  1169  			     GFS2_LOG_HEAD_FLUSH_FREEZE))
24972557b12ce8 Benjamin Marzinski  2014-05-01  1170  			gfs2_log_shutdown(sdp);
24972557b12ce8 Benjamin Marzinski  2014-05-01  1171  	}
24972557b12ce8 Benjamin Marzinski  2014-05-01  1172  
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1173  out_end:
fe3e397668775e Andreas Gruenbacher 2020-12-10  1174  	used_blocks = log_distance(sdp, sdp->sd_log_flush_head, first_log_head);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1175  	reserved_revokes += atomic_read(&sdp->sd_log_revokes_available);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1176  	atomic_set(&sdp->sd_log_revokes_available, sdp->sd_ldptrs);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1177  	gfs2_assert_withdraw(sdp, reserved_revokes % sdp->sd_inptrs == sdp->sd_ldptrs);
2129b4288852cf Andreas Gruenbacher 2020-12-17  1178  	if (reserved_revokes > sdp->sd_ldptrs)
2129b4288852cf Andreas Gruenbacher 2020-12-17  1179  		reserved_blocks += (reserved_revokes - sdp->sd_ldptrs) / sdp->sd_inptrs;
30fe70a85a909a Bob Peterson        2019-11-13  1180  out:
2129b4288852cf Andreas Gruenbacher 2020-12-17  1181  	if (used_blocks != reserved_blocks) {
8daf6c2b3d8cee Andreas Gruenbacher 2025-08-05  1182  		gfs2_assert_withdraw(sdp, used_blocks < reserved_blocks);
fe3e397668775e Andreas Gruenbacher 2020-12-10 @1183  		gfs2_log_release(sdp, reserved_blocks - used_blocks);

But later, this dereferences sdp->sd_jdesc without checking.

2129b4288852cf Andreas Gruenbacher 2020-12-17  1184  	}
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1185  	gfs2_trans_free(sdp, tr);
fe3e397668775e Andreas Gruenbacher 2020-12-10  1186  	trace_gfs2_log_flush(sdp, 0, flags);
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1187  	return;
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1188  
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1189  out_withdraw:
9e34adb1cc582b Andreas Gruenbacher 2026-03-19  1190  	gfs2_trans_drain(tr);
58e08e8d83ab03 Bob Peterson        2020-06-09  1191  	/**
58e08e8d83ab03 Bob Peterson        2020-06-09  1192  	 * If the tr_list is empty, we're withdrawing during a log
58e08e8d83ab03 Bob Peterson        2020-06-09  1193  	 * flush that targets a transaction, but the transaction was
58e08e8d83ab03 Bob Peterson        2020-06-09  1194  	 * never queued onto any of the ail lists. Here we add it to
58e08e8d83ab03 Bob Peterson        2020-06-09  1195  	 * ail1 just so that ail_drain() will find and free it.
58e08e8d83ab03 Bob Peterson        2020-06-09  1196  	 */
58e08e8d83ab03 Bob Peterson        2020-06-09  1197  	spin_lock(&sdp->sd_ail_lock);
58e08e8d83ab03 Bob Peterson        2020-06-09  1198  	if (tr && list_empty(&tr->tr_list))
58e08e8d83ab03 Bob Peterson        2020-06-09  1199  		list_add(&tr->tr_list, &sdp->sd_ail1_list);
58e08e8d83ab03 Bob Peterson        2020-06-09  1200  	spin_unlock(&sdp->sd_ail_lock);
2ca0c2fbf3ed7f Bob Peterson        2019-11-13  1201  	tr = NULL;
5a61ae1402f152 Andreas Gruenbacher 2020-08-28  1202  	goto out_end;
b3b94faa5fe596 David Teigland      2006-01-16  1203  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

