Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93423D7C8;
	Thu, 11 Sep 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600428; cv=none; b=h6gaImFrW+jjnc/Sib8/SLE+0HMH8LiFT8B9tBR1fW9tbF7VfCtxaC5k4XsFeHL2yQ9E+1iX5Ze3xmkoR2WiNZLHmtBuGJLk8ppDgthwsKMIiI+1U0GAfhBJjyHUlPO/6XbYB4td88nszDjVD0H2SWP0ZSYmFEQ4FAih1+fZmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600428; c=relaxed/simple;
	bh=7Y1g/p6iZza6skOHn7hu32dRsTE6Q4vUODm53ZSfRsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiIjhJ4lifzRTlH0lp0FLMBXQrpdMQEv0qDc1AaOrSCQzgK2XokI3d8oP+scPclfURGwg5HyYweVHN+eZJg2Mpf2FZROJWp4u34el/rmpBS/128akxIN0Ws6Kk+4q5KiWHyTcMU4Y1kqe4jlolWY+8x6CF3zWkVYfQg6fvRCvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnlSvexL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnlSvexL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757600426; x=1789136426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Y1g/p6iZza6skOHn7hu32dRsTE6Q4vUODm53ZSfRsI=;
  b=VnlSvexLdGwLUPhrzAU6BCSPvxWzgTGvF/N23VC80JAtNx72YP0RaJHa
   RY5xrCX1mzpOAgTBZX4IyCUrVmVlHSccXgb5yJq6XDd3uhi92u8tRp8ND
   GMv39JW+LoyeRikMJQU1p4/8ccrNKQYE1fs22UCsi2nc3v0++bjcRxcI6
   H+7/1Qc/kdsEoz0voM+Y/PO7sUHdiXopmf+lgufItSgmqAk1QH1RAytLP
   8XWAUM5/fJqpcvoQnGLp6bDmFfcdjPwklhdId2EDc4iD3YQVIrBe2tqNf
   Zt65ggRuK3p1Youe4eRkmLFInLnSzOvbIfxvlCoivLN06cVgHP9ya7wyf
   w==;
X-CSE-ConnectionGUID: Q7oGGSGsQ76vYhQs3N7T9A==
X-CSE-MsgGUID: iHpJOnlyRuKTVMV+QlnVgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71311419"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="71311419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 07:20:24 -0700
X-CSE-ConnectionGUID: et4gFRYMR6Cuaq8mVNEQbQ==
X-CSE-MsgGUID: qPSCSHpdQVKCwhhKeESM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="204465229"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Sep 2025 07:20:23 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwi9r-0000Nc-2c;
	Thu, 11 Sep 2025 14:20:19 +0000
Date: Thu, 11 Sep 2025 22:20:08 +0800
From: kernel test robot <lkp@intel.com>
To: Alessio Attilio <alessio.attilio.dev@gmail.com>, aahringo@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	teigland@redhat.com, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alessio Attilio <alessio.attilio@engineer.com>
Subject: Re: [PATCH] * dlm: improve lock management and concurrency control
Message-ID: <202509112216.Jvy0G9Jd-lkp@intel.com>
References: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>

Hi Alessio,

kernel test robot noticed the following build errors:

[auto build test ERROR on teigland-dlm/next]
[also build test ERROR on linus/master v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alessio-Attilio/dlm-improve-lock-management-and-concurrency-control/20250911-012449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git next
patch link:    https://lore.kernel.org/r/20250910171706.173976-1-alessio.attilio.dev%40gmail.com
patch subject: [PATCH] * dlm: improve lock management and concurrency control
config: hexagon-randconfig-001-20250911 (https://download.01.org/0day-ci/archive/20250911/202509112216.Jvy0G9Jd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509112216.Jvy0G9Jd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509112216.Jvy0G9Jd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
    6181 |         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
         |                                       ^
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6181:32: error: use of undeclared identifier 'safe'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                  ^
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
>> fs/dlm/lock.c:6189:31: error: use of undeclared identifier 'cb_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                      ^
>> fs/dlm/lock.c:6189:27: error: use of undeclared identifier 'cb'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                  ^
>> fs/dlm/lock.c:6189:31: error: use of undeclared identifier 'cb_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                      ^
>> fs/dlm/lock.c:6189:31: error: use of undeclared identifier 'cb_safe'
>> fs/dlm/lock.c:6189:31: error: use of undeclared identifier 'cb_safe'
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +/safe +6181 fs/dlm/lock.c

597d0cae0f99f6 David Teigland  2006-07-12  6148  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6149  static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
ef0c2bb05f40f9 David Teigland  2007-03-28  6150  {
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6151  	struct dlm_lkb *lkb;
ef0c2bb05f40f9 David Teigland  2007-03-28  6152  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6153  	dlm_lock_recovery(ls);
ef0c2bb05f40f9 David Teigland  2007-03-28  6154  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6155  	while (1) {
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6156  		lkb = NULL;
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6157  		spin_lock_bh(&proc->locks_spin);
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6158  		if (!list_empty(&proc->locks)) {
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6159  			lkb = list_entry(proc->locks.next, struct dlm_lkb,
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6160  					 lkb_ownqueue);
ef0c2bb05f40f9 David Teigland  2007-03-28  6161  			list_del_init(&lkb->lkb_ownqueue);
ef0c2bb05f40f9 David Teigland  2007-03-28  6162  		}
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6163  		spin_unlock_bh(&proc->locks_spin);
ef0c2bb05f40f9 David Teigland  2007-03-28  6164  
ef0c2bb05f40f9 David Teigland  2007-03-28  6165  		if (!lkb)
ef0c2bb05f40f9 David Teigland  2007-03-28  6166  			break;
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6167  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6168  		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT) {
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6169  			set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
597d0cae0f99f6 David Teigland  2006-07-12  6170  			orphan_proc_lock(ls, lkb);
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6171  		} else {
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6172  			set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
597d0cae0f99f6 David Teigland  2006-07-12  6173  			unlock_proc_lock(ls, lkb);
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6174  		}
597d0cae0f99f6 David Teigland  2006-07-12  6175  
597d0cae0f99f6 David Teigland  2006-07-12  6176  		dlm_put_lkb(lkb);
597d0cae0f99f6 David Teigland  2006-07-12  6177  	}
a1bc86e6bddd34 David Teigland  2007-01-15  6178  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6179  	spin_lock_bh(&proc->locks_spin);
a1bc86e6bddd34 David Teigland  2007-01-15  6180  	/* in-progress unlocks */
a1bc86e6bddd34 David Teigland  2007-01-15 @6181  	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
a1bc86e6bddd34 David Teigland  2007-01-15  6182  		list_del_init(&lkb->lkb_ownqueue);
e1af8728f600f6 Alexander Aring 2023-03-06  6183  		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
a1bc86e6bddd34 David Teigland  2007-01-15  6184  		dlm_put_lkb(lkb);
a1bc86e6bddd34 David Teigland  2007-01-15  6185  	}
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6186  	spin_unlock_bh(&proc->locks_spin);
a1bc86e6bddd34 David Teigland  2007-01-15  6187  
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6188  	spin_lock_bh(&proc->asts_spin);
986ae3c2a8dfc1 Alexander Aring 2024-03-28 @6189  	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
986ae3c2a8dfc1 Alexander Aring 2024-03-28  6190  		list_del(&cb->list);
2bec1bbd55cf96 Alexander Aring 2024-03-28  6191  		dlm_free_cb(cb);
a1bc86e6bddd34 David Teigland  2007-01-15  6192  	}
cc9f8fbfb34e86 Alessio Attilio 2025-09-10  6193  	spin_unlock_bh(&proc->asts_spin);
a1bc86e6bddd34 David Teigland  2007-01-15  6194  
85e86edf951a8a David Teigland  2007-05-18  6195  	dlm_unlock_recovery(ls);
597d0cae0f99f6 David Teigland  2006-07-12  6196  }
a1bc86e6bddd34 David Teigland  2007-01-15  6197  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
