Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0B3D4118
	for <gfs2@lists.linux.dev>; Fri, 11 Sep 2026 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109661; cv=none; b=o/7TLAKI5WS98l8kRouDUH9h5qAT/EFKYnZ4GJdgSYUxZYHt1DFi+jNsHUq8rHxgEjXm8M3/DiyVw9bsnVDlwssAom4H+zhliyrYgBg81/eHzUJV+awcmazI/L+/GAaWuIyz2wQPl1/QsuXGGpKS16o4lKb7PNlEG7QkzZoWojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109661; c=relaxed/simple;
	bh=vry3klap9u4GjQNVsbX+2L8vo2NtkD7sLGYczUDYo14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1zodiKwMyi2QsoIV0EbH7lo4NuLUCRDV2f8BcaB7esipCbeUjZ9h5vQh6oP9cf8Ovx0YELSnHQ7uKZm6uPerwa0KX/XRBDPGqrPsX2QY1aTdRZVEZPldG+y5sozM+fuIJiZflmpo5JVOdZPYpTn16SlCnSj8rCqknN8zpWyBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmX+/d4u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmX+/d4u"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so531658a91.2
        for <gfs2@lists.linux.dev>; Thu, 10 Sep 2026 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789109649; x=1789714449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=GmX+/d4uTOtA0nynWQICWCsMmd01j3t8x8P24FrxxtEdVstG/Oa1pDpcCyy36K+hf9
         s07FOmhfVgA1tXeRH9/jq1vEba6iyYRlpbYhiUa5mns5uGGTvtUoL/jtYmLqQRgDx3/t
         lsnW0aGsdGlucCkjRRJ4zhPF13roIjmLvbSCTxpT2C6c+zGjKIXMtv9y7NV2I58/gUvu
         pFpCUt/MV7V371lIxCBQgLpCX4IptExIA79+IcW6ESFsx7WJoS9AWNuR2nakhZi0qzeM
         vsm+iwa02TdGmHbexYC3UtHWiO51eswnBWQCdXoyN+YLoYtdgOfSFM/nEWd1z7NhCfrs
         Q+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789109649; x=1789714449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=FKFk3zhCNj0eKEgXyBIUv5Zu0ei+Huu+mRipiqWE6WM1NGWumsif6/Vlw2Bfkjnt6F
         3tA6TSCeiF8To6TD+6feK+BnTgxqxgw44lZtToalnD5v0497sslLj+VwhBdcH4fKzPMq
         8a0cHifWjohmFvpe1L+0bJp0gA0DXEvOgBBYz1zcP6FmjTIQUBaUXIK51/01oFcehyEx
         S+jE7PLIkbypnLfE7vJPPUBrp/bRd7KAt+p/6+7DMo43V0tUXz5FN2SMaPTd+pF8XsPM
         sQmnQwiRi7MWm/m+4ybyAOs/NK2CWzMkiQV4CPALn3rSEGrRm9WPhEmE54ydOhlBHl+B
         V69g==
X-Gm-Message-State: AFuF++k5ckpZEKAmrLt6aAVPNVW8Sonz7Yk0dal/Bp58tvE81D17Z64t
	jX0qql9wAUYE9jPK/F8d4iDjmogvg8IFlLRRzkUzGCNsC2nidQAuK9dgktgeRddm
X-Gm-Gg: AYBFou1qvBIAPe3gmhEGfBSZrYJVKYNx+f2yaITBamhCuK+Ry5uTVXrmosSNzDP1SVj
	4byKdCu7vp5GmoT43Bov/NyulQOYrl7JzoWDE7HrimK/1/5hg/ZL0QfDBApovXGDQ4k8vZUb7MI
	rFQ+frVp/co1OMs1zIBRYkt7IS3NaIPLLKWPJ4nte3J3Ij7MtVG2HMHbFfMb8fOS6wmElmyPa8f
	MP/u1XJRRh8Y+e9KXdQpg3hPhJazOef6xQ1xUoj8Ua4hvEADfz+WkuHwKrX/pL2udfpxTdR1DwZ
	45VZRtB8hRqS9cbDJ0I4iHU/LSCMZuusyOjAia+wd1a8LlJoo5U2lUlPag0QHSymWWsGsNErmF1
	YVLfEZDYV3bugCSFxj6B4qGl0BXgrf/iEEdyt2+mpmtx6lRjyONzjMy9sFBk8uOUkCUCKLLvbc4
	I20OsoPhQpNCfgzx5JMfnOb+vOriNwTpVg95qs3zAKoBaBvgsjGDCVPVZs/aumjTdq/hMB5qJ6m
	ktv2IYXrpcKV2H09fzO0Aq2B2xwLY9rTPyHFJnyFvma7ws=
X-Received: by 2002:a17:90a:da8f:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39d9bc1007dmr3989259a91.5.1789109649253;
        Thu, 10 Sep 2026 23:54:09 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39da1ad5d79sm1830549a91.12.2026.09.10.23.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:54:08 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com,
	teigland@redhat.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: fix RCOM_LOOKUP length underflow
Date: Fri, 11 Sep 2026 14:53:51 +0800
Message-ID: <20260911065357.3511466-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

receive_rcom_lookup() derives the resource name length from the
peer-supplied 16-bit h_length header field:

    int len = le16_to_cpu(rc_in->rc_header.h_length) -
              sizeof(struct dlm_rcom);

The 3.1 receive path only bounds h_length to the range
[sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
dlm_validate_incoming_buffer(), and the RCOM case in
dlm_midcomms_receive_buffer_3_1() performs no further length check
despite its "length already checked" comment.  A peer can therefore
send an RCOM_LOOKUP message whose h_length is smaller than
sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
arithmetic and wraps, and the result is assigned to an int as a
negative value.

Both consumers of that length only guard the upper bound
(len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
comparison:

- with rc_id == 0xffffffff, len reaches dlm_dump_rsb_name() ->
  dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
  and overflows the on-stack 64-byte key buffer;
- otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
  where jhash() converts it to a huge u32 and reads out of bounds.

Drop the message when the computed name length falls outside
[0, DLM_RESNAME_MAXLEN], which is exactly the range valid lookups
use.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 fs/dlm/rcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index be1a71a6303a..14d5ab658f60 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -385,6 +385,9 @@ static void receive_rcom_lookup(struct dlm_ls *ls,
 	int len = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
 
+	if (len < 0 || len > DLM_RESNAME_MAXLEN)
+		return;
+
 	/* Old code would send this special id to trigger a debug dump. */
 	if (rc_in->rc_id == cpu_to_le64(0xFFFFFFFF)) {
 		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
-- 
2.43.7

