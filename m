Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20632EA3;
	Mon, 30 Oct 2023 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtpD4IgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698636658; x=1730172658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rXbXMh9odsjFHqsgjV8QG9+ME5okvudqMryRdwx5z80=;
  b=GtpD4IgP7gAreX+k/8Kfpr/ES28xoL1kVSkWJld06vWftJrsbIHOL8pn
   BD/h8Iz1CHvqTdJkD7FOc7B7mynUJ5V1EPdoO2SvG146PZCH7pgM7P1+V
   nFFPakdM63r8sCuc2mQTQin6mN/Kn71OrYZT0zCZ5FEDcg0TdpQsrXwTL
   77/AoWwSVr5OT1TKALHAPNqfvxJ7zxCT5H9z0PgiAz0Aq+UsmbO+FmK6X
   9CrSyzYy2HKkQqKeSLJrLeEU75UAzfnuFgEgs9L1+TaZzI5ehSsmAA1I1
   bOKH3SGC641s7K+nvQImIk7RRx74J/G12vgNQDPwGetuUlGbu//+gFdca
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373058097"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="373058097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 20:30:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="903860364"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="903860364"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2023 20:28:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxIzO-000D1D-0r;
	Mon, 30 Oct 2023 03:30:54 +0000
Date: Mon, 30 Oct 2023 11:30:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 70/70] bmap.c:undefined reference to `__udivdi3'
Message-ID: <202310301114.rEnyIX9a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git alloc
head:   f8dd6e4dd990a2524b3d76fd2459d027628420eb
commit: f8dd6e4dd990a2524b3d76fd2459d027628420eb [70/70] gfs: Smaller journal reservations in gfs2_iomap_write_alloc
config: powerpc-randconfig-002-20231030 (https://download.01.org/0day-ci/archive/20231030/202310301114.rEnyIX9a-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301114.rEnyIX9a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301114.rEnyIX9a-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/gfs2/bmap.o: in function `gfs2_iomap_write_alloc.isra.0':
>> bmap.c:(.text+0x80e8): undefined reference to `__udivdi3'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
