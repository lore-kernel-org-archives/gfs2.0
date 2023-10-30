Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3746A2;
	Mon, 30 Oct 2023 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE7FdOXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698646946; x=1730182946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rDWEzWn050coEVy1NJ3YXNaE185eL+Ipj+VJBikGZoY=;
  b=RE7FdOXzpculGWF9fmMMA5tUxHYQPHV53VzZkQMJpTbZ8twrXe/6/ee2
   88bA45haETOIK7fENERTizbb3NvkUwH3wQYxlxAAikJSYaS+udbsCSf+E
   KYh2OANtL95dGbQ59YogaJ2TIBc74PnL7U1tNK3aT6sk6UAA8GyC0l2rO
   lcDmhhX/yW++PIpNkd3qlHVVM+4bN++Bg8mhIHnVf3rZvpdj2ZgMnB58E
   rz73NnB31DRiF2PHPK/dd82WFbk0CaNAcCTDuiR0S35Q6GNYmoQ5Hc17N
   R3ANO2MbRdEot10gS2tMw/lxPqoMoy5XVRx64xAEGPi+H47TEGKV+6X2X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="386913916"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="386913916"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 23:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="883770375"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="883770375"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2023 23:22:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxLfJ-000D57-0t;
	Mon, 30 Oct 2023 06:22:21 +0000
Date: Mon, 30 Oct 2023 14:21:22 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 70/70]
 bmap.c:(.text.gfs2_iomap_write_alloc.isra.0+0x69c): undefined reference to
 `__udivdi3'
Message-ID: <202310301436.mYDJZKxK-lkp@intel.com>
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
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231030/202310301436.mYDJZKxK-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301436.mYDJZKxK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301436.mYDJZKxK-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `__kernel_entry':
   (.text+0x0): relocation truncated to fit: R_MIPS_26 against `kernel_entry'
   arch/mips/kernel/head.o: in function `smp_bootstrap':
   (.ref.text+0xd8): relocation truncated to fit: R_MIPS_26 against `start_secondary'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x10): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x18): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0x50): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x58): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x90): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x98): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0xd0): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xd8): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x108): additional relocation overflows omitted from the output
   mips-linux-ld: fs/gfs2/bmap.o: in function `gfs2_iomap_write_alloc.isra.0':
>> bmap.c:(.text.gfs2_iomap_write_alloc.isra.0+0x69c): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
