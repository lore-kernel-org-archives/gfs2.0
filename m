Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609D31195A;
	Thu, 13 Nov 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069061; cv=none; b=MIhUx2PCwMOAfrKluYUIdK1khMGJS8SUOiyFsljDp7MUZrZ7CzCDVPZQrsieEX/CFW2HCeBzA4GGFgLEz20SNDzwrfu4vmVKdisM1B/V/gV3G34FAKGxuuDi75cQZGtpz58CiTGvdOCXE5kR66V7wWZnbQ7JhakPO0qimYDLiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069061; c=relaxed/simple;
	bh=ZfUZKyIsQu/Tb4yvVxl1LcYxlu57ruMwT56TMDmhSD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cUQ2L6yo0JjQ3KCOZZIhWaAVeURgGE9akv8JEgl6+xcPN2QfUfwZtKWgAhMumGwTfi2YH6ob9HAlm0Q9val+9QrxoVc8WPppDAF1XBiV305wU4IdserOQP0dVEVDPBP3COt9PcHoGyXIIlqsgZT9Uu25zRLWAq1bHYRP3x7PTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcpNENZq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcpNENZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763069059; x=1794605059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZfUZKyIsQu/Tb4yvVxl1LcYxlu57ruMwT56TMDmhSD8=;
  b=HcpNENZqlOIQZ7AafKEUf77eTVd9Pz8qwqNg+zV+FfaRcPJv2mBALi4f
   njOokSEnsyXA6a6j+PZHOCpCs2TOXoLAFTSa2nwVPK5DwhzLnj5lMimiK
   4/AcYY6CYoINz/tPZdLuqnt3oibBWP+8AcxfSziUp8FRlIdpCvu6XPbxn
   V/uHfvWe6QTROdVu89Xvx369xRQuzke7zfP1A12DqrbHnanlQ8mmwQt9U
   3GrVVT7fh+keR0YMumg/S46lClcAv9QtygEQpzne2xKoV9bEg9ooY8lEa
   R56RzsbJJSK7I+y0qKrRYTKij6T6dU4xqi9OC/Tc7uc03ctVxatuUrsAQ
   g==;
X-CSE-ConnectionGUID: KRATt8a3St+4S1k3cZD91A==
X-CSE-MsgGUID: TOvnCyL7TfW1O6aTP8Zs+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65202008"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65202008"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:24:16 -0800
X-CSE-ConnectionGUID: BAppU1aDQE2aAZPFS2AkXA==
X-CSE-MsgGUID: OnJK56rGSAyC0v5XDLYwBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189435649"
Received: from igk-lkp-server01.igk.intel.com (HELO 230842de89ac) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2025 13:24:15 -0800
Received: from kbuild by 230842de89ac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vJend-0000000017V-0EYU;
	Thu, 13 Nov 2025 21:24:13 +0000
Date: Thu, 13 Nov 2025 22:23:52 +0100
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:e2 4/4] Warning: fs/gfs2/super.c:1297 function parameter 'gh'
 not described in 'evict_unlinked_inode'
Message-ID: <202511130438.7VNcUEZp-lkp@intel.com>
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
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251113/202511130438.7VNcUEZp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130438.7VNcUEZp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511130438.7VNcUEZp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/super.c:1297 function parameter 'gh' not described in 'evict_unlinked_inode'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
