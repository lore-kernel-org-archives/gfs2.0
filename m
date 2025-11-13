Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4B33DEF4;
	Thu, 13 Nov 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035451; cv=none; b=jNE09TDKc/DLDyqcq8p26J7r7W2abmKlSqJcboYpgjfHvn5cr0CGl6LGHtNdooRTuzN6Jfj0YTrsTaRT3xTYZzgGArg+j1iiZAG3vX95h9ZLPEMMIPECftzZ4DwqNA4y5hb4R0wKKDTpzDPbuFz9h+VyxHow64Ig9ywJFm4LExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035451; c=relaxed/simple;
	bh=5Bgy8w0BOKxy9ewJMSK8ay19uv00IbONEG386rYJaYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jf8HpVxH2sXfSzEYmjZebxibZTxy42Kyj/HkQlaR/rgGPk/TOYQtToHTF+09U64g38gu1jKbt67Rd68JkpyMlcYeC2LjTGYsVv6LqFlxRiByhyrdZ6caJ79uuAlrorTP5b/1snaM0zcNofYsxgT1Yy/KrqYlbZZt3m6d91hWvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1i9odE4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1i9odE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763035450; x=1794571450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Bgy8w0BOKxy9ewJMSK8ay19uv00IbONEG386rYJaYk=;
  b=b1i9odE40wBg3ZkrNErqY91JBpg0KDsKuXksi3/ZJhRgC3NvH71oovCL
   62XXoIbSsT9E4A2S0ZesPsrz4Key2sY9u0PinfgSpd+Gnn18Sx5O9PCrE
   CHMGNFaqSa0dfd1OskAatWzypMy1EsXAiLO+WUoAazabbrQIQVTkIfxCi
   ByEThFcedT9nHTqPbPpj4d+h30ySpnDdm73ec/KVRYreSz9fiwQDyuSD8
   HvfSAx8MlOmuf76ZqwVCz/zHNr2jDOBVMblQYiC/V1ZAJkimU5W2Z/V6h
   GRqY9V5t6yO+9l0CtRzy+5yOsp0au3wrBF3ItR98lrdUeMPd/FZFY4enF
   Q==;
X-CSE-ConnectionGUID: uoGWCLlNSOSB7l4iQvdlxQ==
X-CSE-MsgGUID: ZzxM8emETSOeyiGRYDfJsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68962842"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="68962842"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 04:04:09 -0800
X-CSE-ConnectionGUID: /S6Ony4BTRiEoBdTKvOD9g==
X-CSE-MsgGUID: XtEWJwPlRDuzBab5QQOZ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="193922909"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2025 04:04:09 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJW3Z-0005IL-2o;
	Thu, 13 Nov 2025 12:04:05 +0000
Date: Thu, 13 Nov 2025 20:03:33 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:e2 4/4] Warning: fs/gfs2/super.c:1297 function parameter 'gh'
 not described in 'evict_unlinked_inode'
Message-ID: <202511131953.EIKbaiYJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git e2
head:   a879cfb41053acfcf88ec959b4dbc595a6fc2105
commit: a879cfb41053acfcf88ec959b4dbc595a6fc2105 [4/4] gfs2: Fix data loss during inode evict
config: powerpc-randconfig-r072-20251113 (https://download.01.org/0day-ci/archive/20251113/202511131953.EIKbaiYJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131953.EIKbaiYJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131953.EIKbaiYJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/super.c:1297 function parameter 'gh' not described in 'evict_unlinked_inode'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
