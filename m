Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8631F98B;
	Sun, 16 Aug 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786851610; cv=none; b=WAVtP16oZoUdRnl1Ki1D6nUQq1N9iALBRSbk5votgkmUy65h0goGlr1We7xV+sZoX1v6AdbC4PNaThx8aWloaR3MnQF5bFgNOBJF9bbImVbJouD8Ko73SODFwBa1mNgd6HVxqVXEsLeihhaz4Vow77F8XnZbcCXGJPfzvnlLS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786851610; c=relaxed/simple;
	bh=zFCLUvtakTdmg0IIeQdk2MA4nA9gf5hqf0b5UjkpsAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHqCmXlYrP7p4ra64SpYRgqWw/fyEDzAlG3UNRoj+abqm2meh+/a9XG+V3cs1nR1b7A2LP/F6znDfGlYoeBILNuVQ+cM7n079jxWXlL6Uzvd5mz1/3ejR7R95HeKqEroniGj8lump+/EszJYFIDLR3rW8p1aReH1bf2Vn8hb8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TELu8aD0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TELu8aD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786851607; x=1818387607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFCLUvtakTdmg0IIeQdk2MA4nA9gf5hqf0b5UjkpsAU=;
  b=TELu8aD07b7yAWv+NPJbeaCA0waTnmqngZHGNWB0x57hzDflii0uDg6G
   EszabjVnhY/9gvVB8hu2shJUB3ewxOQ1BuEfwhpT4me/Ybt6A/6CCCJKq
   VxRE2EGMKHh12eb9DKu8i8pqARD6GunRPyr1j9fnqNDTUZ0ona22oFhB6
   h0c9dnAIrOmJN7Mqe/DknLQ6h/Ko3NMv2l69cqxWVS2zAPLsISja+J2Nu
   /vz+ZPPqT/r4hVU8iYiOfOoxjMibdg6K5PlzresYoirB1gOH8cNeEaD49
   boIijVGA6X8ZuX32Ni+E3BS++otkh8j8KiqDM5Fp2Vb8e8kcXvJM73HLY
   Q==;
X-CSE-ConnectionGUID: c3QnnguwQ3KOt0k67TV6lg==
X-CSE-MsgGUID: tJyXW/g0RiGBn12qhuC73w==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="86330993"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="86330993"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 20:40:06 -0700
X-CSE-ConnectionGUID: KnrUeb4EQlG8wG+kavy6Dg==
X-CSE-MsgGUID: afsDVCh1QruW7Xog8nvtiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="294509265"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2026 20:40:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvRj7-00000000cj4-2C00;
	Sun, 16 Aug 2026 03:40:01 +0000
Date: Sun, 16 Aug 2026 11:39:49 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Garcia Casado <adriangarciacasado42@gmail.com>,
	gfs2@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	rpeterso@redhat.com, agruenba@redhat.com
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Message-ID: <202608161126.D7TCuQKF-lkp@intel.com>
References: <6a439397.39c9bec7.125ac1.2db8@mx.google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a439397.39c9bec7.125ac1.2db8@mx.google.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on gfs2/for-next]
[also build test WARNING on linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Garcia-Casado/gfs2-add-missing-__rcu-annotation-to-i_gl-in-incore-h/20260814-021232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
patch link:    https://lore.kernel.org/r/6a439397.39c9bec7.125ac1.2db8%40mx.google.com
patch subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
config: sh-randconfig-r123-20260816 (https://download.01.org/0day-ci/archive/20260816/202608161126.D7TCuQKF-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 9.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608161126.D7TCuQKF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608161126.D7TCuQKF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/gfs2/inode.c:150:41: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected struct gfs2_glock **glp @@     got struct gfs2_glock [noderef] __rcu ** @@
   fs/gfs2/inode.c:150:41: sparse:     expected struct gfs2_glock **glp
   fs/gfs2/inode.c:150:41: sparse:     got struct gfs2_glock [noderef] __rcu **
   fs/gfs2/inode.c:181:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:181:54: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:181:54: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:188:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:188:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:188:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/inode.c:199:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/inode.c:199:52: sparse:     expected void volatile *addr
   fs/gfs2/inode.c:199:52: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/inode.c:206:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:206:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:206:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:212:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:212:54: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:212:54: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:244:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:244:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:244:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:342:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:342:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:342:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:343:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:343:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:343:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:459:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:459:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:459:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:553:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:553:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:553:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:554:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:554:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:554:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:580:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:580:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:580:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:581:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:581:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:581:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:729:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:729:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:729:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:835:80: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected struct gfs2_glock **glp @@     got struct gfs2_glock [noderef] __rcu ** @@
   fs/gfs2/inode.c:835:80: sparse:     expected struct gfs2_glock **glp
   fs/gfs2/inode.c:835:80: sparse:     got struct gfs2_glock [noderef] __rcu **
   fs/gfs2/inode.c:857:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:857:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:857:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:860:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/inode.c:860:46: sparse:     expected void volatile *addr
   fs/gfs2/inode.c:860:46: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/inode.c:873:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:873:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:873:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:917:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:917:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:917:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:936:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:936:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:936:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1000:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1000:12: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1000:12: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1060:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1060:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1060:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1061:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1061:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1061:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1134:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1134:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1134:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1260:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1260:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1260:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1261:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1261:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1261:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1535:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1535:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1535:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1537:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1537:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1537:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1541:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1541:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1541:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1545:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1545:37: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1545:37: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1781:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1781:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1781:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1783:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1783:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1783:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1787:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1787:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1787:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1790:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1790:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1790:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1921:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1921:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1921:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2111:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2111:38: sparse:     expected struct gfs2_glock *gl
--
   fs/gfs2/file.c:66:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:66:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:66:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:112:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:112:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:112:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:169:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:169:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:169:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:228:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:228:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:228:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:245:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:245:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:245:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:265:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:265:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:265:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:433:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:433:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:433:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/file.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/file.c:458:31: sparse:     expected void volatile *addr
   fs/gfs2/file.c:458:31: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/file.c:560:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:560:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:560:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:600:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:600:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:600:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:683:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:683:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:683:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:770:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:770:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:770:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:840:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:840:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:840:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:903:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:903:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:903:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:983:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:983:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:983:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1037:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1037:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1037:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1054:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1054:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1054:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1115:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1115:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1115:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1192:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1192:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1192:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1393:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1393:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1393:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
   fs/gfs2/bmap.c:1834:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1834:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1834:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1954:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1954:60: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1954:60: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1989:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1989:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1989:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:81:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:81:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:81:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:127:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:127:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:127:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:681:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:681:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:681:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:725:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:725:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:725:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:751:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:751:55: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:751:55: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:753:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:753:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:753:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:763:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:763:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:763:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:996:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:996:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:996:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/bmap.c:1199:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/bmap.c:1199:31: sparse:     expected void volatile *addr
   fs/gfs2/bmap.c:1199:31: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/bmap.c:1416:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1416:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1416:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1588:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1588:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1588:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1622:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1622:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1622:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2034:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2034:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2034:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2139:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2139:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2139:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2390:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2390:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2390:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1708:42: sparse: sparse: unsigned value that used to be signed checked against zero?
   fs/gfs2/bmap.c:2006:16: sparse: signed value source

vim +199 fs/gfs2/inode.c

2c5f4a53476e3ca fs/gfs2/inode.c     Andreas Gruenbacher 2025-11-13  104  
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  105  /**
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  106   * gfs2_inode_lookup - Lookup an inode
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  107   * @sb: The super block
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  108   * @type: The type of the inode
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  109   * @no_addr: The inode number
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  110   * @no_formal_ino: The inode generation number
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  111   * @blktype: Requested block type (GFS2_BLKST_DINODE or GFS2_BLKST_UNLINKED;
61b91cfdc6c0c49 fs/gfs2/inode.c     Andreas Gruenbacher 2017-08-01  112   *           GFS2_BLKST_FREE to indicate not to verify)
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  113   *
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  114   * If @type is DT_UNKNOWN, the inode type is fetched from disk.
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  115   *
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  116   * If @blktype is anything other than GFS2_BLKST_FREE (which is used as a
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  117   * placeholder because it doesn't otherwise make sense), the on-disk block type
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  118   * is verified to be @blktype.
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  119   *
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  120   * When @no_formal_ino is non-zero, this function will return ERR_PTR(-ESTALE)
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  121   * if it detects that @no_formal_ino doesn't match the actual inode generation
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  122   * number.  However, it doesn't always know unless @type is DT_UNKNOWN.
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  123   *
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  124   * Returns: A VFS inode, or an error
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  125   */
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  126  
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  127  struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  128  				u64 no_addr, u64 no_formal_ino,
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  129  				unsigned int blktype)
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  130  {
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  131  	struct inode *inode;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  132  	struct gfs2_inode *ip;
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  133  	struct gfs2_holder i_gh;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  134  	int error;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  135  
6df9f9a253c7dc9 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-17  136  	gfs2_holder_mark_uninitialized(&i_gh);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  137  	inode = iget5_locked(sb, no_addr, iget_test, iget_set, &no_addr);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  138  	if (!inode)
ac3beb6a5de048e fs/gfs2/inode.c     Steven Whitehouse   2014-01-16  139  		return ERR_PTR(-ENOMEM);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  140  
e97321fa095f1ea fs/gfs2/inode.c     Bob Peterson        2016-04-12  141  	ip = GFS2_I(inode);
e97321fa095f1ea fs/gfs2/inode.c     Bob Peterson        2016-04-12  142  
40a4c512ad25640 fs/gfs2/inode.c     Mateusz Guzik       2025-10-09  143  	if (inode_state_read_once(inode) & I_NEW) {
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  144  		struct gfs2_sbd *sdp = GFS2_SB(inode);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  145  		struct gfs2_glock *io_gl;
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  146  		int extra_flags = 0;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  147  
2c5f4a53476e3ca fs/gfs2/inode.c     Andreas Gruenbacher 2025-11-13  148  		gfs2_setup_inode(inode);
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  149  		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE,
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  150  				       &ip->i_gl);
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  151  		if (unlikely(error))
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  152  			goto fail;
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  153  
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  154  		error = gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CREATE,
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  155  				       &io_gl);
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  156  		if (unlikely(error))
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  157  			goto fail;
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  158  
2ec750a01d189cf fs/gfs2/inode.c     Andreas Gruenbacher 2022-12-04  159  		/*
2ec750a01d189cf fs/gfs2/inode.c     Andreas Gruenbacher 2022-12-04  160  		 * The only caller that sets @blktype to GFS2_BLKST_UNLINKED is
2ec750a01d189cf fs/gfs2/inode.c     Andreas Gruenbacher 2022-12-04  161  		 * delete_work_func().  Make sure not to cancel the delete work
2ec750a01d189cf fs/gfs2/inode.c     Andreas Gruenbacher 2022-12-04  162  		 * from within itself here.
2ec750a01d189cf fs/gfs2/inode.c     Andreas Gruenbacher 2022-12-04  163  		 */
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  164  		if (blktype == GFS2_BLKST_UNLINKED)
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  165  			extra_flags |= LM_FLAG_TRY;
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  166  		else
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  167  			gfs2_cancel_delete_work(io_gl);
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  168  		error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED,
c7d7d2d345697eb fs/gfs2/inode.c     Andreas Gruenbacher 2022-10-09  169  					   GL_EXACT | GL_NOPID | extra_flags,
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  170  					   &ip->i_iopen_gh);
29464ee36bcaaee fs/gfs2/inode.c     Andreas Gruenbacher 2022-01-24  171  		gfs2_glock_put(io_gl);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  172  		if (unlikely(error))
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  173  			goto fail;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  174  
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  175  		if (type == DT_UNKNOWN || blktype != GFS2_BLKST_FREE) {
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  176  			/*
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  177  			 * The GL_SKIP flag indicates to skip reading the inode
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  178  			 * block.  We read the inode when instantiating it
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  179  			 * after possibly checking the block type.
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  180  			 */
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  181  			error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE,
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  182  						   GL_SKIP, &i_gh);
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  183  			if (error)
40e7e86ef16550c fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-24  184  				goto fail;
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  185  
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  186  			error = -ESTALE;
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  187  			if (no_formal_ino &&
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  188  			    gfs2_inode_already_deleted(ip->i_gl, no_formal_ino))
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  189  				goto fail;
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  190  
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  191  			if (blktype != GFS2_BLKST_FREE) {
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  192  				error = gfs2_check_blk_type(sdp, no_addr,
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  193  							    blktype);
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  194  				if (error)
40e7e86ef16550c fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-24  195  					goto fail;
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  196  			}
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  197  		}
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  198  
f2e70d8f2fdff07 fs/gfs2/inode.c     Bob Peterson        2021-10-06 @199  		set_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  200  
2b0fb353c029de7 fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  201  		/* Lowest possible timestamp; will be overwritten in gfs2_dinode_in. */
580f721b6f5ad5a fs/gfs2/inode.c     Jeff Layton         2023-10-04  202  		inode_set_atime(inode,
580f721b6f5ad5a fs/gfs2/inode.c     Jeff Layton         2023-10-04  203  				1LL << (8 * sizeof(inode_get_atime_sec(inode)) - 1),
580f721b6f5ad5a fs/gfs2/inode.c     Jeff Layton         2023-10-04  204  				0);
2b0fb353c029de7 fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  205  
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  206  		glock_set_object(ip->i_gl, ip);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  207  
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  208  		if (type == DT_UNKNOWN) {
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  209  			/* Inode glock must be locked already */
f2e70d8f2fdff07 fs/gfs2/inode.c     Bob Peterson        2021-10-06  210  			error = gfs2_instantiate(&i_gh);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  211  			if (error) {
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  212  				glock_clear_object(ip->i_gl, ip);
40e7e86ef16550c fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-24  213  				goto fail;
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  214  			}
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  215  		} else {
2b0fb353c029de7 fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  216  			ip->i_no_formal_ino = no_formal_ino;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  217  			inode->i_mode = DT2IF(type);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  218  		}
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  219  
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  220  		if (gfs2_holder_initialized(&i_gh))
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  221  			gfs2_glock_dq_uninit(&i_gh);
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  222  		glock_set_object(ip->i_iopen_gh.gh_gl, ip);
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  223  
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  224  		gfs2_set_iop(inode);
b8e12e3599ad61b fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  225  		unlock_new_inode(inode);
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  226  	}
332f51d7db13ffb fs/gfs2/inode.c     Andreas Gruenbacher 2016-09-26  227  
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  228  	if (no_formal_ino && ip->i_no_formal_ino &&
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  229  	    no_formal_ino != ip->i_no_formal_ino) {
b66648ad6dcfefd fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-15  230  		iput(inode);
b8e12e3599ad61b fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  231  		return ERR_PTR(-ESTALE);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  232  	}
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  233  
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  234  	return inode;
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  235  
40e7e86ef16550c fs/gfs2/inode.c     Andreas Gruenbacher 2020-01-24  236  fail:
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  237  	if (error == GLR_TRYFAILED)
c412a97cf6c5253 fs/gfs2/inode.c     Bob Peterson        2022-08-22  238  		error = -EAGAIN;
5f6e13baebf31d7 fs/gfs2/inode.c     Andreas Gruenbacher 2021-11-29  239  	if (gfs2_holder_initialized(&ip->i_iopen_gh))
763766c0571ea14 fs/gfs2/inode.c     Bob Peterson        2021-09-29  240  		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
6df9f9a253c7dc9 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-17  241  	if (gfs2_holder_initialized(&i_gh))
3ce37b2cb491767 fs/gfs2/inode.c     Andreas Gruenbacher 2016-06-14  242  		gfs2_glock_dq_uninit(&i_gh);
9ffa18884cceb2e fs/gfs2/inode.c     Andreas Gruenbacher 2023-01-23  243  	if (ip->i_gl) {
9ffa18884cceb2e fs/gfs2/inode.c     Andreas Gruenbacher 2023-01-23  244  		gfs2_glock_put(ip->i_gl);
9ffa18884cceb2e fs/gfs2/inode.c     Andreas Gruenbacher 2023-01-23  245  		ip->i_gl = NULL;
9ffa18884cceb2e fs/gfs2/inode.c     Andreas Gruenbacher 2023-01-23  246  	}
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  247  	iget_failed(inode);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  248  	return ERR_PTR(error);
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  249  }
194c011fc4650d0 fs/gfs2/ops_inode.c Steven Whitehouse   2011-05-09  250  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
