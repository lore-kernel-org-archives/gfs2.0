Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786138;
	b=SzBZ1La2/QnKhYU7qvlg1K0KLpq8q1n6i72hwaVxFP0VkbztSaJQb41DyppWEE/Fb7Cp
	 qc4mnXru+m6o3E4B74ArBqJQyCFQbhzt+W4P9wJzW0PfPtFDZ99CKN5kbXFxLCDDVv7YR
	 +TANsq7AR8WlexA5v4IxkOXXhF14TwhccQwCtMhPjpdWE9C9trb0LvDwkhzxtvrYIC1/Q
	 TCeg7PHBsWY7WUOSOHeyGb4qtDDyeMVFlxbWZK3MypU4blZuSEGbDHQYTynxPWFP2vmhA
	 aykwC3uuM6fxeDk3cU9oVU4EJ9e0vr8NFbR7krr7d8YotvwdgV22ZNiKRe1WK5EAXPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ci8AQvKazANwLNbOXSd+IPKnNkJbp750aHA9N2kTOY4=;
	b=pnsaWtCyI+iqoTZFQ7TNYHv9eH0+LVdRY2z9NkraHlmu0nW21AZPf4shwjAytfsapngX
	 qj6NLnb5tKj5tNlESg1Gy5Ft7TwU4a9O6uP7jR4Jk16jvGHMz82eUJuPKicCr1x7iNpW3
	 GczVhUh+ees/uMpfA8M8TnZFP+WWzt5GiY9pxN2PyUj6WjjOtZZgayUu0oEwKJOVNexei
	 SnyhPOt5vhx3n/2J2gg1W28Ejz8VH+HqOv401IyXrBfpqIpwgnDlaATlnYqWa0PZ+giif
	 LdJ3VPSp2q5i6wXcT5HlxTsAvSmF8OVMeOHCeXxtDGx4MZ+5orMxNVWTm6kRoqI+F2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6xLcWAj;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BA606D82F
	for <gfs2@lists.linux.dev>; Wed,  4 Nov 2026 09:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77BA606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6xLcWAj
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed11653a91so1188485ad.2
        for <gfs2@lists.linux.dev>; Wed, 04 Nov 2026 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793786137; x=1794390937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ci8AQvKazANwLNbOXSd+IPKnNkJbp750aHA9N2kTOY4=;
        b=l6xLcWAjPIDy8igu17flWODuQnFe0fgmChOhXQgch7uu3BZiHe++2cxVKWH7X7y8n0
         zMGpC2/l3d0VwOeCox2Z3hgaEqR73eveMUr+6fVEOxKiMvi10T1z2QVxOcQ3g6S73Xt+
         ilDKSjyHIFYjnl6k+5KQWQmSmUtBPhVSocURTepmC6ulc68dD31s8NHfugJsd3jg0+c1
         XQE8+JO6RqYb5miVk9Z3TmtcoHW4WDBkOAarYoW4yErnmPCgGfLmCLeDnLbj6LIKWsXO
         G46G6iHZL6xqPfbcJQkuNczXlvWM4rQ3FDQ36/GyyZLqwxbxrr4cHHY3E9LixVn8XzJ9
         abog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786137; x=1794390937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ci8AQvKazANwLNbOXSd+IPKnNkJbp750aHA9N2kTOY4=;
        b=BtmJvx7JBrYq8vVrd82xSmOw5+HCDKhEfMIlb1PSFiNrVMK4nni9BKnd37QLVHSYH0
         r1qV5kHhanfxgaChyWwyXaTRIHK2gatklxwlXHDr/d6aJIvflwbqcSacXRuzKjKUuox+
         ATiA5whNjXjA3m13ucVKw3P6Bsk8AeHiPB8vgdqi7mczGxKxp+d/g/JaEoQcHKtvqLJV
         kJWvlO0pfoa2QU65KXhUeKUPwTTUKhRc3ngwKt11AnfkNW4x5ikIFBnOCFyrLGk/4N0T
         VddVgdmJQKxMgkv944+dolDgx1YM4xOZlncPBKkFv8sQDz8sdlUjoxmSzEu+ZgrnqEBQ
         1jrA==
X-Gm-Message-State: APuU4Z8vRVnDym0ZR+X1ksrV7dLqtQ0X7jTYKrpaRiOWop+X7DjBevKb
	u7zmPPzp0/l5y1nYAvL4IRRtvew2abaiZJ/7mM1I6seMcYJ/P9bW/4pW
X-Gm-Gg: AYBFou06QgCYU/l6nkw9wx5mtKbCxndUsCUOSBplrIB3XL7+fem1H5nLf16ZvuQ0jhN
	AOnGLdhTFQyne8+BugCwdevgdUZ0pV/DfvM8hCdU/lMfTHiF0seF9hgrUOiZ1qZCpqNJ3kv5ixN
	2fBIfkjtsJD9mlm1e9OqB6uR1C22WjwEN/SAYTrLAuNJvzMe1ddQdckVUbMsSRKuOzwN2okZLbe
	6ZbsSGSvSKjyldwsDtN/7jXw+fa2OLOs8uj48PV9d+vB0+OS5bD7W1tevBxI7dFvxDIL2wxYY6H
	E/YJrRkgryzqHYOkGAMyC8J3h7D5sHNUjPfmGa6Olg2h+EykJzMtGd5cCEOGulo5nEpqBABH2JQ
	QkJsES0YGq4pyImzo45Y2S6G5mK9ARf/IUoGQf25vyAPweoWk1s63Nvgs0G7Xy4X0ZlMAvvr4ZP
	uF+NOdLqXzMtII14mICzy3xkRIeEy0gXk8nkQuLWR5nHqszVtxTHqKg2mj4jm+dNFqvNvWW5XlY
	FBp4Jg4h/Bbg73+HoQ8fiuTYHViFuZKPepVhg3a0Tc2D6UJpVeuQLGuhGYqxXtiQBhIW7nN8iQc
	SzFUrlqgY1NniQq3MyU30eM66EMbsZEvfS4765ZVS0bb2rtzfA==
X-Received: by 2002:a17:902:cec9:b0:2e8:5202:aa8c with SMTP id d9443c01a7336-2eb364f0a21mr145807865ad.48.1793786137198;
        Wed, 04 Nov 2026 01:55:37 -0800 (PST)
Received: from localhost.localdomain ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe1e6asm5591535ad.22.2026.11.04.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:55:36 -0800 (PST)
From: Qing Zhang <diasyzhangqing@gmail.com>
X-Google-Original-From: Qing Zhang <diasyzhang@tencent.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+bad65435361712796381@syzkaller.appspotmail.com,
	diasyzhangqing@gmail.com,
	Qing Zhang <diasyzhang@tencent.com>
Subject: [PATCH] gfs2: Fix refcount of quota data restored at mount
Date: Wed,  4 Nov 2026 17:55:30 +0800
Message-ID: <20261104095530.4178727-1-diasyzhang@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <683e2b6d.a00a0220.d8eae.005b.GAE@google.com>
References: <683e2b6d.a00a0220.d8eae.005b.GAE@google.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_init() resets the lockref count to 0 despite setting
QDF_CHANGE, which owns a reference released by do_qc().  Quota syncing
can therefore consume a concurrent user's reference, leaving the
count at 0 and triggering the assertion in __qd_hold().

Keep the initial reference from qd_alloc().  During cleanup, clear
the in-memory change and slot state and drop the QDF_CHANGE reference
for objects with no other references.  Leave the on-disk quota change
records untouched for recovery on the next mount.

Fixes: bb73ae8ff394 ("gfs2: Fix initial quota data refcount")
Reported-by: syzbot+bad65435361712796381@syzkaller.appspotmail.com
Closes: https://syzbot.appspot.com/bug?extid=bad65435361712796381
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---
If QDF_CHANGE remains set at teardown, a concurrent sysfs quota_refresh
can make cleanup skip a restored object during remount-ro or unmount.
The last external put then leaves the QDF_CHANGE reference behind,
whereas before this patch it could dispose of the object with the
journal shut down.  Feedback on handling this reference safely would
be appreciated.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

 fs/gfs2/quota.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b2984fb7b35c..29eb7adc4284 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1470,7 +1470,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			if (qd == NULL)
 				goto fail_brelse;
 
-			qd->qd_lockref.count = 0;
 			set_bit(QDF_CHANGE, &qd->qd_flags);
 			qd->qd_change = qc_change;
 			qd->qd_slot = slot;
@@ -1542,6 +1541,12 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
 	spin_lock(&qd_lock);
 	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
 		spin_lock(&qd->qd_lockref.lock);
+		if (qd->qd_lockref.count == 1 &&
+		    test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
+			qd->qd_change = 0;
+			qd->qd_slot_ref = 0;
+			qd->qd_lockref.count = 0;
+		}
 		if (qd->qd_lockref.count != 0) {
 			spin_unlock(&qd->qd_lockref.lock);
 			continue;
-- 
2.43.7

