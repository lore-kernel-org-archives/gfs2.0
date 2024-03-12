Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12011428F9
	for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275136; cv=none; b=M6VejnBEkgpIU5wiwIv6O0a0RdKFFE57ykmj7gnUCvCOFnkNvr4cW0XGbfxgDKctacd9x2q8qWNsP68ptg74AcH38ipl97D+4NoDX2+beFcXRguve5xM2kTnDmclGitLf8BmIgsqJlaBo4TdYem3EXBOKESmS+ROgsES4OeK1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275136; c=relaxed/simple;
	bh=twDyd8XtyARuIynyt/yejmxOwEaYl4mikiQ2nZ8ASxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ7CoMHDrA9hmJfy2DNhCzHINojx8clQmW62poY7oWwERrCFYeTGpn0bgz8Ia6epAhLDWuVmqBu75tm0G4mD1+Ks62pUAQLOz2FQutAaYs+asf8DKvYtz93d4lL35WfcqYNLuzQll8xIsBYqOb9EPqRZZeKOFUc6NHiYs4at6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b=ki+OoF2p; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="ki+OoF2p"
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=valentin-vidic.from.hr; s=2020; t=1710275127;
	bh=twDyd8XtyARuIynyt/yejmxOwEaYl4mikiQ2nZ8ASxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki+OoF2puXZq6Mpv1iu4UgHO13gCDE8cGFD/nACB76sA+6nIVURpjnJIyORYvjr4V
	 gmikO6JWjwlOTX6wfOtyM2mbBnI9avBl05b2XbA6oSnlZcuCNA6zMArTwSYzmreEPg
	 tT7qhCAIWWWc0GHGiDX9LzCdyI4AZ3K/213dImwqRehAvjDvO0/n+6S7LePTNM9HfS
	 /OqP4ZlN2eEX83mcOc3JSFOOHbr+g4rZZ/fgdiSvP3nn5YvwCOANN5oAcaUlKXsiJA
	 hSA2eDXkNsOV/9XLzqdwmvV4u17kIwj/Iq2uX14a6iH/+GBxP7ijPyJNXYwVptZypP
	 K+SigrmqU0DHpgRwK91VjWR+fz8Kt5al1r3WayYPaHSAZXlUHlrIxKlJmMYGAeJ35u
	 HQkVjWgY7u+jHgutLfyT7ps1DL2H7VtA8j2t0PkJ/zUeTuaq2Y9E/uwbENmTbOX96X
	 ajXWHkixNop+bwcabDzpBMisv5++fSn1fBS/qrcTI2wF6zh/Lfe8T5rMXP2dBuH9g8
	 OsJdqVGKLFs4UAoaKPivZE7ScbCz1F465VboWLUt+JPbzyRu4FqE4IZssl7/eqLZS2
	 Hbb5BxClGplTZCl76XZasIAuTqViXjmMIaEy7tqSRKpSJJEoXTt5jjqt37JnLsb5v2
	 GpRDBlBZgscz8Hf/A88SoGYA=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id EDBCA2D2EF; Tue, 12 Mar 2024 21:25:27 +0100 (CET)
Date: Tue, 12 Mar 2024 21:25:27 +0100
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, stable@vger.kernel.org,
	joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com,
	heming.zhao@suse.com
Subject: Re: [PATCH 2/2] dlm: fix off-by-one waiters refcount handling
Message-ID: <ZfC6NxRpmAFSNg79@valentin-vidic.from.hr>
References: <20240312170508.3590306-1-aahringo@redhat.com>
 <20240312170508.3590306-2-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312170508.3590306-2-aahringo@redhat.com>

On Tue, Mar 12, 2024 at 01:05:08PM -0400, Alexander Aring wrote:
> There was a wrong conversion to atomic counters in commit 75a7d60134ce
> ("fs: dlm: handle lkb wait count as atomic_t"), when
> atomic_dec_and_test() returns true it will decrement at first and
> then return true if it hits zero. This means we will mis a unhold_lkb()
> for the last iteration. This patch fixes this issue and if the last
> reference is taken we will remove the lkb from the waiters list as this
> is how it's supposed to work.
> 
> Cc: stable@vger.kernel.org
> Fixes: 75a7d60134ce ("fs: dlm: handle lkb wait count as atomic_t")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Tested-by: Valentin Vidić <vvidic@valentin-vidic.from.hr>

-- 
Valentin
