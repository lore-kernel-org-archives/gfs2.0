Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EF3AF67D
	for <gfs2@lists.linux.dev>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148929; cv=none; b=qV1f9nykvJZ+E+AKYmYMEzR5ykHV459lVay4SWBLD39xEXvznsiEerizggJyCZ7ZnxlHfX49OYTQYOXGxMLznEWZqHHP0jBEMBgxz/KmR5u2rkkqHngT8Ohn1KDyX6cXW5k47H1P/9ggeCI7aA8hI0ySJwcOcxJmab1gsoKHTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148929; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IiJsggJODEXdpzY4uV3Yya6e+xQjryZbqmRIymGWm3g2FhVwxZsRF6Y5YyKm08C/PVB2xWU32TD17xuU/4ziBCFMP9xXQ/Hm662c0JjsejSG5LyUFMnmMSsp1U7r1l2OY1Da4jsOQu9q+E1LDYgW9KvMy/tGhgnhGXL0UOlEPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQQpd+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQQpd+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
	HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
	RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-0VbDJ3F0N0-XdGHv78m5Pg-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: 0VbDJ3F0N0-XdGHv78m5Pg-1
X-Mimecast-MFC-AGG-ID: 0VbDJ3F0N0-XdGHv78m5Pg_1773148925
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7ea0bb20so1450836485a.3
        for <gfs2@lists.linux.dev>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=aGZ4bknf8Od8nnOqE9dB/p4zmwpM97bGNAEDsIGn3TFWR3I+VLC1tgcPkIIWVXUwW0
         vCkk7D82Z40nSmUd8rPqfrnoS4OZ2yyAtLDdur7CDgrRej/o0QMR0Jj9ulMSj0mNtcGS
         Bro/5ijHV2leuLTNpktFkvRPWD4RbMIZ1D8Hy4Uy9V+Z8pBsUsAgFvSVNfB7z3f/xobN
         96JyWitQzJzNkD1EzRDZdpcCYHnrsbwLWYpH5yx76PgFlLZI+faHYLHnJtDZ0Fb0+SIY
         tyLOS6n+YfVtlI6NCNIcgqYzBMs1T4qBHLHC1CHqhGjQGyx62cHqXGMW3ueDk+K5Lejm
         V87w==
X-Forwarded-Encrypted: i=1; AJvYcCUehuRQ4gXYPo+eoGI8IN3XB/6cGE9GlMkqR1dc9HNayeTQN6tIfD8Z9tTDOycs9+7ca+ly@lists.linux.dev
X-Gm-Message-State: AOJu0YzLX93kv0ubHm55E+vdKl2hzNkHcq8D1eYePUWtz3xhNQkYeauR
	RgBHEbeVcRW790NKuM0FQ5AzzoXeOIzhk/+k1/dzuiQl4dBVGJdWlCpsMRR+O8U1sYsSPk02Vlp
	Edy51FuJoG2IlHp7KBB0PbSqAJQCC4/wcyHTz6bY3m9A76s5cK1QvQB8=
X-Gm-Gg: ATEYQzxClpqo5JwA3EHuYqCJHMMJvGG06DFOQTsQPpGNvu64UB6JvRhSnroyQK4cwsM
	gYTLDRqsjNvkm387MYQYPTgQL4pFEFZVaokMixPRJY+zlqLSCExzPCNHbkFAI6bhgOPCZ88KZGm
	297TP+/uji7SzRH1RQCWiAI4uZrYsbk6R1uLmIzdvq+3iGjJA2v8W1Vdrk5O03mkNcBQHcaOOes
	dSNGKmy79OgrZ3R4IgAfJIjj2mL0lhKwmjzY43bjDX6aI7bBQR5OsPMM1WjLDoX1Dy5rgbsnQZp
	AlKxF5yZ0uujtiFZwYT1pNMAjTScgRUZP0EVYXsmrpVrTt8oev1Ybxuw6QRZ1AOKpL4KpRr6A8J
	34Tc8d+V7iNa14sv0Nd3rxJrnaTl361jQVhzyE7RLZz/htP6L+BWYog7G
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830783185a.45.1773148924639;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v2fZHRBAbHvQviTvrJ7a6srL69A_FjRJJsjfHDMspIA_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

