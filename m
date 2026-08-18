Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7D47A880
	for <gfs2@lists.linux.dev>; Tue, 18 Aug 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062107; cv=none; b=cva5u4C1t+iCFAfFJ9JPB33GHoGM0fmb9Hwg+6Fxh7CQjuILL4ERVEKERIhIcjbdsqCr4619MJeTnC5TEv0vTpWPQiYli85MHm2ZgUDAEXKpPYMnG4YqkQUH5z3yLLa69j64RvbzXRSUuXyVwQBVWYvspgaQ5+OdNBVmGOLZtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062107; c=relaxed/simple;
	bh=9XZRxkrof600ecgVtrO3Vx8Wg7+sTs7IcawTQqSua3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJFwKZS45f9gXlOOR/0T6GNVcsvFKiDtnN5MW7CJMpO9lHQhrVvKBghqPN7gAHHvk02saGrI1E9TwnLnpXrn3g6TOISrC8gbsZgmzxt+R3UxskANYoP1p2PXm4I3/CYtlZRnmWq2JilV+q0P5XQJ2AdBM5zJz2Vkp4hKg1hFVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=h2ANa7hV; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="h2ANa7hV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vKhPvxEZ00/uWwYTk11jSPLcZTTXoUul/73rG/XWMzE=; b=h2ANa7hV2Zb5604W8o2813BzO6
	sGFOTpVmgepQtWC0QJu8+ls3Wj8rFrON4UGXY+k5egYHpYEUoNTpjehtyll1ZctmeBeWn0h6GFN1c
	HhH6qqe/bnaQKw98YR4k4OPcpGx8X8p/rUyn4oK7tWD9f1ZPxfXOq9hWL2eZMboQp7bMuJzlc4yvA
	j4OaG94iGpJ7atF6PIxfF59Irq1UxVSI0D8HvBsEpyBj+nvfG2y/twY38o4rn63chtuIiFngZy/zX
	Clz2QuK+QseluOot5cjFqxQIXkIxMYmuprFKNy+ibwbw0UJfqcpoIDI0uX8bXDtubRz145q49OTBU
	XgI9s87w==;
Received: from [151.115.150.205] (port=51026 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wwKUK-0000000B8Sl-47lL;
	Tue, 18 Aug 2026 16:08:24 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] dlm: reject wrapped messages with oversized inner lengths
Date: Tue, 18 Aug 2026 14:07:47 +0000
Message-ID: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Reject DLM_OPTS packets whose wrapped inner message length exceeds the
bytes remaining inside the validated outer packet. This keeps malformed
wrapped RCOM replies from reaching downstream length-driven copies.

Fixes: 489d8e559c65 ("fs: dlm: add reliable connection if reconnect")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 fs/dlm/midcomms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 8964164600d2..7953a205244a 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -652,6 +652,14 @@ static int dlm_opts_check_msglen(const union dlm_packet *p, uint16_t msglen,
 		return -1;
 	}
 
+	p = (const union dlm_packet *)((const unsigned char *)p->opts.o_opts +
+				       le16_to_cpu(p->opts.o_optlen));
+	if (le16_to_cpu(p->header.h_length) > len) {
+		log_print("inner msg too large: %u > %d, will skip this message from node %d",
+			  le16_to_cpu(p->header.h_length), len, nodeid);
+		return -1;
+	}
+
 	return 0;
 }
 
-- 
2.47.3

